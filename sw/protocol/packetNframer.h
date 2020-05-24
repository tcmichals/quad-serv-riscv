/*
    Transport for parsing packets
    Copyright (C) 2020  Tim Michals

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

*/

#pragma once
#include <iostream>
#include <cstdint>
#include <array>
#include <functional>
#include <algorithm>
#include "ringBuffer.h"
#include "crc16.h"


/*

Some what follows RFC1662 Framing but the max length is 128 bytes


ESC: 0x7D
SOP: 		1 byte  	Start of packet,  0x7E
from_port:	1 byte		0 .. 0x7C or 0xFF (broadcast)
to_port:	1 byte		0 .. 0x7C or 0xFF (broadcast)
length:     1 byte		
PAYLOAD:
CRC-16		2 bytes         CRC16
EOP:        1 byte		End of packet 0x7F
*/

#define PACKET_SOP          0x7E
#define PACKET_EOP          0x7F

#define MAX_PACKET_LEN      128
#define ESC_PACKET          0x7D
#define BROADCAST_PORT      0xFF
#define PORT_MAX ((ESC_PACKET) -1)
#define PAYLOAD_MAX_LENGTH ((MAX_PACKET_LEN) - 7)

#define PACKET_SOP_OFFSET  0
#define PACKET_EOP_OFFSET  ((MAX_PACKET_LEN) -1)
#define PACKET_FROM_PORT_OFFSET  1
#define PACKET_TO_PORT_OFFSET  2
#define PACKET_PAYLOAD_OFFSET  4

#define MAX_PORTS 10

#ifdef DEBUG_PRINTF

#endif
class basicProtocol
{
public:
	typedef std::array<uint8_t, MAX_PACKET_LEN> pkt_t;
	typedef std::function< bool (uint8_t from_port,
								uint8_t *pPayload,
								size_t sizeOfPayLoad)> postPayloadCallback_t;
	typedef std::function< bool (uint8_t *pPkt, size_t len)> txPacket_t;



protected:
		pkt_t m_txPkt;
		pkt_t m_rxPkt;
		ringBuffer<uint8_t, MAX_PACKET_LEN * 2> m_rxRB;
        uint8_t m_rxOffset;
        postPayloadCallback_t m_postPayLoadCallback;
		txPacket_t m_txFunc;

		class payloadCBArgs
		{
			public:
				payloadCBArgs(): m_toPort(0xFF) {}
				~payloadCBArgs(){}

				uint8_t 			  m_toPort;
				postPayloadCallback_t m_callback;
		};
		
		std::array<payloadCBArgs, MAX_PORTS> m_callbackList; 

protected:
        uint8_t xor_byte( uint8_t packet_byte);

        bool isValidPacket();
        bool postPacket();


public:
    basicProtocol();
    virtual ~basicProtocol();

   bool post(uint8_t to_port, const postPayloadCallback_t &callback);
   bool isValidPort ( uint8_t port );

   bool send_packet( uint8_t to_port,
           	   	   	 uint8_t from_port,
					 uint8_t *payload,
					 size_t lenOfPayload);

   bool onRecv( uint8_t *pRx, size_t lenOfBytes);
   bool registerTx( const txPacket_t  &tx);



};

inline
basicProtocol::basicProtocol(): m_rxOffset(0)
{

}

inline
basicProtocol::~basicProtocol()
{

}

inline
bool basicProtocol::post(uint8_t to_port, const postPayloadCallback_t &callback)
{
 	for( auto &entry : m_callbackList)
 	{
		 if (entry.m_toPort ==  0xFF)
		 {
			 entry.m_toPort = to_port;
			 entry.m_callback = callback;
			 break;
		 }
 	}
}


inline
uint8_t basicProtocol::xor_byte( uint8_t packet_byte)
 {
	return packet_byte ^ 0x20;
 }

inline
bool basicProtocol::isValidPort ( uint8_t port )
{
	if ( port < PORT_MAX || port==BROADCAST_PORT)
		return true;

	return false;
 }

inline
 bool basicProtocol::send_packet( uint8_t to_port,
                  uint8_t from_port,
                  uint8_t *payload,
				  size_t lenOfPayload)
 {

	size_t packet_offset = 0;

	if ( !isValidPort(to_port))
		return false;

	if ( !isValidPort(from_port))
		return false;

	if(lenOfPayload > PAYLOAD_MAX_LENGTH)
			return false;

	m_txPkt[packet_offset++] = PACKET_SOP;
	m_txPkt[packet_offset++] = from_port;
	m_txPkt[packet_offset++] = to_port;
	m_txPkt[packet_offset++] = 0;

	for(size_t payload_offset=0; payload_offset < lenOfPayload && packet_offset< m_txPkt.size() ;++payload_offset)
	{
		uint8_t packet_byte = payload[payload_offset];

		if ((packet_byte == PACKET_SOP) || (packet_byte == PACKET_EOP) ||( packet_byte == ESC_PACKET))
		{
			m_txPkt[packet_offset++] = ESC_PACKET;
			m_txPkt[packet_offset++] = xor_byte(packet_byte);
		}
		else
		{
			m_txPkt[packet_offset++] = packet_byte;
		}
	}

	//pad packet to MAX_PACKET_LEN -3
	for(;packet_offset < MAX_PACKET_LEN -3; ++packet_offset)
		m_txPkt[packet_offset] = 0;

	if (packet_offset + 3 > m_txPkt.size())
		return false;

	uint16_t crc = crc16(m_txPkt.data(), packet_offset);
	m_txPkt[packet_offset++] = crc >> 8;
	m_txPkt[packet_offset++] = crc;
	m_txPkt[packet_offset++] = PACKET_EOP;

	if (m_txFunc)
		m_txFunc(m_txPkt.data(), packet_offset);
	return true;
 }

 inline
 bool basicProtocol::postPacket( )
 {
		uint8_t from_port, to_port, value;
		uint16_t crc;

	 	if ( false == m_rxRB.pop(value)  || value!= PACKET_SOP)
		 	return false;

	 	if ( false == m_rxRB.pop(from_port))
		 	return false;

		if (false == m_rxRB.pop(to_port))
			return false;

		if (!isValidPort(from_port))
			return false;

		if (!isValidPort(to_port))
			return false;

		/* reserved */
		if ( false == m_rxRB.pop(value))
		 	return false;

		for(size_t index=0; index < PAYLOAD_MAX_LENGTH;index++)
		{
			if ( false == m_rxRB.pop(value))
		 		return false;

			m_rxPkt[index] = value;
		}

		uint16_t CRC;

		if ( false == m_rxRB.pop(value))
		 		return false;

		CRC = value << 8;

		if ( false == m_rxRB.pop(value))
		 		return false;

		CRC |= value;

		if ( false == m_rxRB.pop(value) || PACKET_EOP!= value)
			return false;


		if ( CRC != crc16(m_rxPkt.data(), PAYLOAD_MAX_LENGTH))
		{
		//		return false;
		}

		for(size_t index=0, offset=0; offset < PAYLOAD_MAX_LENGTH;index++, offset++)
		{
			uint8_t value = m_rxPkt[offset];
			switch(value)
			{
		    	case ESC_PACKET:
				{
					offset++;
					if (offset < PAYLOAD_MAX_LENGTH)
	                	m_rxPkt[index] = xor_byte(value);
				}
		        break;

		        default:
		        	 m_rxPkt[index] = value;
		        break;
			}
		}
		for(auto &entry: m_callbackList)
		{
			if ( entry.m_toPort == to_port && entry.m_callback)
			{
				return entry.m_callback(from_port, m_rxPkt.data(), PAYLOAD_MAX_LENGTH);
			}
		}
		return false;
	}


 

 inline
 bool basicProtocol::onRecv( uint8_t *pRx, size_t lenOfBytes)
 {
	 do
	 {
         /* validate packet state machine */
		 m_rxRB.push(*pRx++);
		lenOfBytes--;

		if (m_rxRB.size() == MAX_PACKET_LEN)
			postPacket();

	 }while(lenOfBytes);

	 return false;

 }

inline
  bool basicProtocol::registerTx(const txPacket_t  &txfunc)
  {
	  m_txFunc = txfunc;
  }


  


