#include <array>
#include <iostream>
#include <iomanip> // std::setiosflags, std::resetiosflags
#include <cstdint>
#include <memory>
#include <vector>
#include <deque>
#include <atomic>
#include <tuple>
#include <chrono>
#include <thread>
#include <string>

#include <boost/asio.hpp>


class nativeSerialPort
{
    public:
        typedef std::function< bool (uint8_t *pRx, size_t lenOfRx)> rxCallback_t;
        typedef std::vector<uint8_t> txData_t;
    public:
        nativeSerialPort(boost::asio::io_context &io_context);
        virtual ~nativeSerialPort();
        bool open(const std::string &name, size_t baudrate=4000000);
        bool close();
        bool postTX( const txData_t &tx);
        void do_write();



    protected:
            enum buffer_tx
            {
                buffer_size = 512
            };
        std::unique_ptr<boost::asio::serial_port>   m_serialPort;
        boost::asio::io_context                     &m_io_context;
        std::array<uint8_t, buffer_size>            m_rxBuffer;
        std::array<uint8_t, buffer_size>            m_txBuffer;

        std::size_t                                 m_txBytesToTransmit;
        std::size_t                                 m_txBytesSent;

        rxCallback_t                                m_rxCallback;
        std::deque<txData_t>                        m_txQueue;
        std::atomic<bool>                           m_isTxRunning;

        void start_write();
        void keep_writing();
        void start_read();

};

inline
nativeSerialPort::nativeSerialPort(boost::asio::io_context &io_context): m_io_context(io_context),
                                                             m_txBytesToTransmit(0),
                                                             m_txBytesSent(0),
                                                             m_isTxRunning(false)
                                                            

{

}

inline
nativeSerialPort::~nativeSerialPort()
{

}

inline 
bool nativeSerialPort::open(const std::string &name, size_t baudrate)
{
    boost::system::error_code ec;
    bool rc = false;

    try
    {
        m_serialPort = std::make_unique<boost::asio::serial_port>(m_io_context);
        m_serialPort->open(name);
        if (!m_serialPort->is_open())
            return false;

        m_serialPort->set_option(boost::asio::serial_port_base::baud_rate(baudrate));
        m_serialPort->set_option(boost::asio::serial_port_base::flow_control(boost::asio::serial_port_base::flow_control::type::none));
        m_serialPort->set_option(boost::asio::serial_port_base::character_size(8));
        m_serialPort->set_option(boost::asio::serial_port_base::parity(boost::asio::serial_port_base::parity::none));
        m_serialPort->set_option(boost::asio::serial_port_base::stop_bits(boost::asio::serial_port_base::stop_bits::type::one));

        start_read();
        //      int fd = m_serialPort->native_handle();
        //ioctl(fd, TIOCGSERIAL, &serial);
        //serial.flags |= ASYNC_LOW_LATENCY;
        //ioctl(fd, TIOCSSERIAL, &serial);
    }
    catch (boost::system::error_code &ex)
    {
        rc = false;
    }
    catch (std::exception &ex)
    {
        std::cerr << __PRETTY_FUNCTION__ << " " << ex.what() << std::endl;
        rc = false;
    }
    catch (...)
    {
        rc = false;
    }

    return rc;
}

inline 
bool nativeSerialPort::close()
{

return true;
}


inline
void nativeSerialPort::keep_writing()
{
    boost::asio::async_write(*m_serialPort.get(),
                             boost::asio::buffer(m_txBuffer.data() + m_txBytesSent, m_txBytesToTransmit - m_txBytesSent,
                             [this](boost::system::error_code ec, std::size_t length) 
                             {
                                 if (ec)
                                 {
                                     std::cerr << "Error:" << ec.message() << std::endl;
                                     m_serialPort->close();
                                 }
                                 else
                                 {
                                     m_txBytesSent += length;
                                     if (m_txBytesToTransmit == m_txBytesSent)
                                     {
                                         m_isTxRunning = false;
                                         m_io_context.post([this]() { start_write(); });
                                     }
                                     else
                                     {
                                         m_txBytesSent += length;
                                         m_io_context.post([this]() { keep_writing(); });
                                     }
                                 }
                             });

}

inline 
void nativeSerialPort::start_write()
{
    if (m_isTxRunning == false && m_txQueue.size())
    {
        m_isTxRunning = true;    
        m_txBytesToTransmit = m_txQueue[0].size();
        m_txBytesSent = 0;
        memcpy(m_txBuffer.data(), m_txQueue[0].data(), m_txQueue[0].size());
        keep_writing();
    }


}


/**
 * @brief 
 * 
 */
inline void nativeSerialPort::start_read()
{
    m_serialPort->async_read_some(boost::asio::buffer(m_rxBuffer, m_rxBuffer.size()),
                                  [this](const boost::system::error_code &ec, std::size_t length) 
                                  {
                                      if (!ec)
                                      {
                                        if (m_rxCallback)
                                        {
                                            m_rxCallback(m_rxBuffer.data(), length);
                                        }
                                        start_read();
                                      }  
                                      else
                                      {
                                       std::cerr << "trash" << std::endl;
                                      }
                                  });
}


inline 
bool nativeSerialPort::postTX( const txData_t &tx)
{
    if (tx.size() > buffer_size)
        return false;

    m_txQueue.push_back(tx);
    start_write();
    return;
}



//EOF
