
/*
    Read and Write 32 bit memory
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

#include <cstdint>
#include <atomic>
#include <array>
#include <stddef.h>
#include <string.h>
#ifdef PC_DEBUG
#include <boost/format.hpp>
#endif
#include "basicProtocol.h"



#define READ_WRITE_PROTOCOL_PORT 0x1
#define MAX_READWRITE_SIZE 8

enum class typeOfReadOrWrite
{
    ContiguousRead = 0,
    ContiguousWrite = 1,

};

enum class ErrorCode
{
    OK = 0,
};

typedef struct 
{
    uint8_t m_version;      // always 0
    uint8_t m_operation;    // ContiguousRead or ContiguousWrite
    uint8_t m_size;         // number of reads or writes
    uint8_t m_majic;        // used to match up requests
    uint32_t m_address;     // address to perform operations
    uint32_t m_values[MAX_READWRITE_SIZE]; //read values

}operationPayload_t;


class readWriteMemoryProtocolServer
{

    public:

        readWriteMemoryProtocolServer(basicProtocol &protocol);
        virtual ~readWriteMemoryProtocolServer();


    protected:  
        basicProtocol &m_protocol;
        operationPayload_t m_payload;

    bool postFromBasicProtocol( uint8_t from_port, uint8_t *pPayload, size_t sizeOfPayload);
       

};

inline 
readWriteMemoryProtocolServer::readWriteMemoryProtocolServer(basicProtocol &protocol): m_protocol(protocol)
{
    auto foo = std::bind(&readWriteMemoryProtocolServer::postFromBasicProtocol,
                            this,
                            std::placeholders::_1,
                            std::placeholders::_2,
                            std::placeholders::_3);
                            
    m_protocol.post(static_cast<uint8_t>(READ_WRITE_PROTOCOL_PORT), foo);
}
inline
readWriteMemoryProtocolServer::~readWriteMemoryProtocolServer()
{

}


inline     
bool readWriteMemoryProtocolServer::postFromBasicProtocol( uint8_t from_port, uint8_t *pPayload, size_t sizeOfPayload)
{

    if (sizeOfPayload <= offsetof(operationPayload_t, m_values))
    {
        return false;
    }

    operationPayload_t *pOperation = reinterpret_cast<operationPayload_t *>(pPayload);
    uint32_t *pValues = pOperation->m_values;

    switch( static_cast<typeOfReadOrWrite>(pOperation->m_operation))
    {
        case typeOfReadOrWrite::ContiguousRead:
        {
            volatile uint32_t *pMemory = reinterpret_cast<uint32_t *>(pOperation->m_address);
            memset(&m_payload, 0, sizeof(m_payload));
            for(size_t offset=0, numOfReads = pOperation->m_size; numOfReads; numOfReads--, pMemory++, offset++)
            {
                #ifdef PC_DEBUG
                    m_payload.m_values[offset] = reinterpret_cast<std::uintptr_t>(pMemory);
                    printf("Majic %d Address: %p value %04X\n", pOperation->m_majic, pMemory, m_payload.m_values[offset]);
                #else
                    m_payload.m_values[offset] = *pMemory ;
                #endif
         
            }
            m_payload.m_operation = pOperation->m_operation;
            m_payload.m_size      = pOperation->m_size ;
            m_payload.m_majic     = pOperation->m_majic;
            m_payload.m_address   = pOperation->m_address;

            m_protocol.send_packet(from_port, READ_WRITE_PROTOCOL_PORT, reinterpret_cast<uint8_t *>(&m_payload), sizeof(m_payload) );

        }
        break;


        case typeOfReadOrWrite::ContiguousWrite:
        {
            uint32_t *pMemory = reinterpret_cast<uint32_t *>(pOperation->m_address);

            for(; pOperation->m_size; pOperation->m_size--, pMemory++, pValues++)
            {
                #ifdef PC_DEBUG
                      std::cout <<boost::format("%p") % pMemory << " " << boost::format("0x%04X") % *pValues << std::endl;
                #else
                    *pMemory = *pValues;
                #endif
            }
        }
        break;

        default:
        break;
    }
}


