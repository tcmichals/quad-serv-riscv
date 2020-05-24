
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
using boost::asio::ip::udp;
class udpServer
{

public:
    typedef std::function<bool(uint8_t *pRx, size_t lenOfRx)> rxCallback_t;
    typedef std::vector<uint8_t> txData_t;

    udpServer(boost::asio::io_context &io_context);
    virtual ~udpServer();
    bool open(uint16_t port);
    bool assignRXCallback(const rxCallback_t &callback);
    bool postTX(uint8_t *pTx, size_t lenght);

protected:
    enum buffer_tx
    {
        buffer_size = 512
    };

    boost::asio::io_context &m_io_context;
    std::array<uint8_t, buffer_size> m_rxBuffer;
    std::array<uint8_t, buffer_size> m_txBuffer;
    std::size_t m_txBytesToTransmit;
    std::size_t m_txBytesSent;
    std::unique_ptr<udp::socket> m_socket;
    udp::endpoint m_sender_endpoint;
    rxCallback_t m_rxCallback;
    std::deque<txData_t> m_txQueue;
    std::atomic<bool> m_isTxRunning;

    void start_read(void);

    void keep_writing();
    void start_write();
};

inline udpServer::udpServer(boost::asio::io_context &io_context) : m_io_context(io_context),
                                                                   m_txBytesToTransmit(0),
                                                                   m_txBytesSent(0),
                                                                   m_isTxRunning(false)

{
}
udpServer::~udpServer()
{
}

bool udpServer::open(uint16_t port)
{

    try
    {
        m_socket = std::make_unique<udp::socket>(m_io_context,
                                                 udp::endpoint(udp::v4(), (short)port));
        start_read();
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
        return false;
    }
}

bool udpServer::assignRXCallback(const rxCallback_t &callback)
{
    m_rxCallback = callback;
    return true;
}

inline bool udpServer::postTX(uint8_t *pTx, size_t len)
{
    if (len > buffer_size)
        return false;

    std::vector<uint8_t> tx(pTx, pTx+ len);
    m_txQueue.push_back(tx);
    start_write();
    return true;
}

void udpServer::start_read()
{
    m_socket->async_receive_from(boost::asio::buffer(m_rxBuffer.data(), m_rxBuffer.size()),
                                 m_sender_endpoint,
                                 [this](boost::system::error_code ec, std::size_t length) {
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
                                     }
                                 });
}

inline void udpServer::start_write()
{
    if (m_isTxRunning == false && m_txQueue.size())
    {
        m_isTxRunning = true;
        m_txBytesToTransmit = m_txQueue[0].size();
        m_txBytesSent = 0;
        memcpy(m_txBuffer.data(), m_txQueue[0].data(), m_txQueue[0].size());
        m_txQueue.pop_front();
        keep_writing();
    }
}

inline void udpServer::keep_writing()
{
    m_socket->async_send_to(boost::asio::buffer(m_txBuffer.data() + m_txBytesSent, m_txBytesToTransmit - m_txBytesSent),
                            m_sender_endpoint,
                            [this](boost::system::error_code ec, std::size_t length) {
                                if (ec)
                                {
                                    std::cerr << "Error:" << ec.message() << std::endl;
                                    m_socket->close();
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

// eof
