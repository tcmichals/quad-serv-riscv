#include <stdint.h>
#include <signal.h>
#include <iostream>
#include <memory>
#include <deque>

#include "verilated_vcd_c.h"
#include "Vquadsoc_tb.h"

#include <fstream>

using namespace std;

static bool done;

vluint64_t main_time = 0; // Current simulation time
// This is a 64-bit integer to reduce wrap over issues and
// allow modulus.  You can also use a double, if you wish.

double sc_time_stamp()
{                   // Called by $time in Verilog
  return main_time; // converts to double, to match
  // what SystemC does
}

void INThandler(int signal)
{
  printf("\nCaught ctrl-c\n");
  done = true;
}

class fastSerial
{
protected:
  enum class ftdiFastSerialState_t
  {
    Idle,
    StartBit,
    D0,
    D1,
    D2,
    D3,
    D4,
    D5,
    D6,
    D7,
    SRC,
    DONE,
  };

  enum class fsCLKState_t
  {
    Low,
    RisingEdge,
    High,
    FallingEdge,
  };
  ftdiFastSerialState_t m_rxState;
  ftdiFastSerialState_t m_txState;
  fsCLKState_t m_FSCLK;

  uint8_t m_rxByte;
  uint8_t m_txByte;
  std::deque<uint8_t> m_txData;

  bool rxFromFPGA(Vquadsoc_tb *top);
  bool txToFPGA(Vquadsoc_tb *top);

public:
  fastSerial();
  ~fastSerial();
  bool clock(Vquadsoc_tb *top);
};

inline fastSerial::fastSerial() : m_txByte(0)
{
  m_txData.push_back('0');
//  m_txData.push_back('5');
 // m_txData.push_back('5');
}
inline fastSerial::~fastSerial() {}

inline bool fastSerial::clock(Vquadsoc_tb *top)
{
  bool clkChanged = false;
  if (top->i_rst)
  {
    m_rxState = m_txState = ftdiFastSerialState_t::Idle;
    m_FSCLK = fsCLKState_t::Low;
    top->i_fscts = 1;
    top->i_fsdo = 1;
  }
  else
  {
    /* code */
    if (top->o_fsclk)
    {
      switch (m_FSCLK)
      {
      case fsCLKState_t::Low:
        m_FSCLK = fsCLKState_t::RisingEdge;
        clkChanged = true;
        break;
       case fsCLKState_t::RisingEdge:
         m_FSCLK = fsCLKState_t::High;
         clkChanged = true;
       break;


      case fsCLKState_t::FallingEdge:
      case fsCLKState_t::High:
        m_FSCLK = fsCLKState_t::High;
        break;
      }
    }
    else
    {
      switch (m_FSCLK)
      {
      case fsCLKState_t::High:
        m_FSCLK = fsCLKState_t::FallingEdge;
        clkChanged = true;
        break;

      case fsCLKState_t::FallingEdge:
        m_FSCLK = fsCLKState_t::Low;
        clkChanged = true;
      break;
      case fsCLKState_t::Low:
      case fsCLKState_t::RisingEdge:
        m_FSCLK = fsCLKState_t::Low;
        break;
      }
    }

    if (clkChanged)
    {
      rxFromFPGA(top);
      txToFPGA(top);
    }
  }
  return true;
}

inline bool fastSerial::rxFromFPGA(Vquadsoc_tb *top)
{
  switch (m_rxState)
  {
  case ftdiFastSerialState_t::Idle:
    if (top->o_fsdi == 0 && m_FSCLK == fsCLKState_t::RisingEdge)
    {
      m_rxState = ftdiFastSerialState_t::D0;
      m_rxByte = 0;
    }
    break;

  case ftdiFastSerialState_t::D0... ftdiFastSerialState_t::D7:

    if (m_FSCLK == fsCLKState_t::RisingEdge)
    {
      int shift = static_cast<int>(m_rxState) - static_cast<int>(ftdiFastSerialState_t::D0);

      m_rxByte |= top->o_fsdi << shift;
      top->i_fscts = 0;
      m_rxState = static_cast<ftdiFastSerialState_t>(static_cast<int>(m_rxState) + 1);
    }
    break;

  case ftdiFastSerialState_t::SRC:
    if (m_FSCLK == fsCLKState_t::RisingEdge)
    {
      m_rxState = static_cast<ftdiFastSerialState_t>(static_cast<int>(m_rxState) + 1);
    }
    break;

  case ftdiFastSerialState_t::DONE:
  {
    if (m_FSCLK == fsCLKState_t::RisingEdge)
    {
      m_rxState = ftdiFastSerialState_t::Idle;
      top->i_fscts = 1;
      printf("rx %X\n", (int)m_rxByte);
    }
  }
  break;
  }
}

inline bool fastSerial::txToFPGA(Vquadsoc_tb *top)
{

  switch (m_txState)
  {
  case ftdiFastSerialState_t::Idle:
    if (m_FSCLK == fsCLKState_t::High)
    {
      if (m_txData.size())
      {
        m_txState = ftdiFastSerialState_t::D0;
        top->i_fsdo = 0;
         m_txByte = m_txData[0];
         printf(" TX %02X\n", (int) m_txByte);
        /*
       
        if (m_txByte == '9')
          m_txData.push_back('0');
        else
          m_txData.push_back(m_txByte + 1);
          */
        m_txData.pop_front();
      }
    }
    break;

  case ftdiFastSerialState_t::D0... ftdiFastSerialState_t::D7:

    if (m_FSCLK == fsCLKState_t::FallingEdge)
    {
      top->i_fsdo = m_txByte & 1;
      m_txState = static_cast<ftdiFastSerialState_t>(static_cast<int>(m_txState) + 1);
      m_txByte >>= 1;
    }
    break;

  case ftdiFastSerialState_t::SRC:

    if (m_FSCLK == fsCLKState_t::FallingEdge)
    {
      top->i_fsdo = 0;
      m_txState = static_cast<ftdiFastSerialState_t>(static_cast<int>(m_txState) + 1);
    }
    break;
  case ftdiFastSerialState_t::DONE:
  {
      m_txState = ftdiFastSerialState_t::Idle;
      top->i_fsdo = 1;
    
  }
  break;
  }
}
int main(int argc, char **argv, char **env)
{
  Verilated::commandArgs(argc, argv);
  Vquadsoc_tb *top = new Vquadsoc_tb();
  fastSerial fserial;

  VerilatedVcdC *tfp = 0;
  const char *vcd = Verilated::commandArgsPlusMatch("vcd=");
  if (vcd[0])
  {
    Verilated::traceEverOn(true);
    tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("trace.vcd");
  }

  vluint64_t timeout = 0;
  const char *arg_timeout = Verilated::commandArgsPlusMatch("timeout=");
  if (arg_timeout[0])
    timeout = atoi(arg_timeout + 9);

  signal(SIGINT, INThandler);

  top->i_clk = 1;
  uint32_t current_pc = 0;
  bool gpioOn = false;

  while (!(done || Verilated::gotFinish()))
  {
    top->i_rst = main_time < 100;
    top->eval();

    fserial.clock(top);
    if (tfp)
      tfp->dump(main_time);

    //TCM FIX top->i_user_btn = !!(main_time & 0x4000);

    if (timeout && (main_time >= timeout))
    {
      printf("Timeout: Exiting at time %lu\n", main_time);
      done = true;
    }
    if (!top->i_rst)
    {
      if (top->o_gpio && gpioOn == false)
      {
        printf("GPIO on\n");
        gpioOn = true;
      }
      else if (!top->o_gpio && gpioOn)
      {
        printf("GPIO off\n");
        gpioOn = false;
      }

      if (current_pc != top->o_pc)
      {
        current_pc = top->o_pc;
      }
    }

    top->i_clk = !top->i_clk;
    main_time += 31.25;
  }
  if (tfp)
    tfp->close();

  exit(0);
}
