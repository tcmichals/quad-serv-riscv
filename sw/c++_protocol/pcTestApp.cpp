#include <iostream>
#include <cstdint>
#include <thread>

#include <boost/asio.hpp>
#define PC_DEBUG
#include "udpServer.h"
#include "readWriteProtocol.h"
#include "basicProtocol.h"


#define UDP_PORT 56000u
/*

socat -d -d pty,raw,echo=0 udp:localhost:56000
socat -d -d pty,raw,echo=0 udp:localhost:56000



*/

static boost::asio::io_context gIOService(1);

basicProtocol UUT;
readWriteMemoryProtocolServer server(UUT);

int main(int argc, char **argv)
{

    boost::asio::signal_set signals(gIOService, SIGINT, SIGTERM);
    signals.async_wait([&](auto, auto){ gIOService.stop(); std::cout<< "stopping" << std::endl; });
    udpServer transPort(gIOService);
    transPort.open(UDP_PORT);

    auto onRX = std::bind(&basicProtocol::onRecv, &UUT,
                std::placeholders::_1,
                std::placeholders::_2);

    transPort.assignRXCallback(onRX);
    auto onTx = std::bind(&udpServer::postTX, &transPort, std::placeholders::_1, std::placeholders::_2);
    UUT.registerTx(onTx);
    gIOService.run();


 


}

//eof
