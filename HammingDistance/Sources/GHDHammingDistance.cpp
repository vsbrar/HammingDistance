// =============================================================================
// GHDHammingDistance.cpp
// =============================================================================

#include "GHDHammingDistance.h"

// ---------------------------------------------------------------------------
// GHDHammingDistance
// ---------------------------------------------------------------------------

// The rational is to XOR the two bit string and get the hamming weight.
//
// For example:
// The Hamming Distance for two bit strings A and B will be
// Hamming Distance = Hamming Weight( A ^ B )
//
// The program uses boost::dynamic_bitset to get the hamming weight. The performance
// of boost::dynamic_bitset on different platforms and compilers needs
// to be tested.
// For example: A better implementation can be using
//              int __builtin_popcount (unsigned int x)
//              function in GCC compiler.
//

// ---------------------------------------------------------------------------
GHDHammingDistance::GHDHammingDistance()
{
    // Empty to support class in containers

    // TODO: Add another constructor to support int bits.
}

// ---------------------------------------------------------------------------
GHDHammingDistance::GHDHammingDistance( const std::string& inBitString1,
                                        const std::string& inBitString2 )
: mBitSet1( inBitString1 )
, mBitSet2( inBitString2 )
{
    // FIXME: Check the string should contain only binary numbers.
    //        The std::bitset has a check for it and throws
    //        std::invalid_argument exception.
    //        The boost::dynamic_bitset only asserts at present.
    if( mBitSet1.size() != mBitSet2.size() )
    {
        // TODO: Add support to turn off exceptions.
        throw std::invalid_argument( "Bit strings length not equal" );
    }
}

// ---------------------------------------------------------------------------
size_t
GHDHammingDistance::GetDistance() const
{
    // TODO: Add support for caching the result.
    boost::dynamic_bitset<> theResult = mBitSet1 ^ mBitSet2;

    return theResult.count();
}
