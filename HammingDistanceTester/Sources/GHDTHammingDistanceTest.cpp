// ===========================================================================
// GHDTHammingDistanceTest.cpp
// ===========================================================================

#include "gtest/gtest.h"

#include "GHDHammingDistance.h"

namespace
{

using namespace std;

// ---------------------------------------------------------------------------
TEST( HammingDistanceTest, testEmptyInput )
{
    const string theEmptyString;

    GHDHammingDistance theHammingDistance( theEmptyString, theEmptyString );
    EXPECT_EQ( 0, theHammingDistance.GetDistance() );
}

// ---------------------------------------------------------------------------
TEST( HammingDistanceTest, testInvalidInput )
{
    const string theBitString1( "0000" );
    const string theBitString2( "000011" );

    EXPECT_ANY_THROW( GHDHammingDistance
                      theHammingDistance( theBitString1, theBitString2 ) );
}

// ---------------------------------------------------------------------------
TEST( HammingDistanceTest, testIncorrectInput )
{
    // FIXME:
//    const string theBitString1( "abcd" );
//    const string theBitString2( "abcd" );
//
//    EXPECT_ANY_THROW( GHDHammingDistance
//                      theHammingDistance( theBitString1, theBitString2 ) );
}

// ---------------------------------------------------------------------------
TEST( HammingDistanceTest, testWithAllBitsSet )
{
    const string theBitStringWithAllBitsSet( "1111" );

    GHDHammingDistance theHammingDistance( theBitStringWithAllBitsSet,
                                           theBitStringWithAllBitsSet );
    EXPECT_EQ( 0, theHammingDistance.GetDistance() );
}

// ---------------------------------------------------------------------------
TEST( HammingDistanceTest, testWithNoBitsSet )
{
    const string theBitStringWithNoBitsSet( "0000" );

    GHDHammingDistance theHammingDistance( theBitStringWithNoBitsSet,
                                           theBitStringWithNoBitsSet );
    EXPECT_EQ( 0, theHammingDistance.GetDistance() );
}

// ---------------------------------------------------------------------------
TEST( HammingDistanceTest, testPositive )
{
    const string theBitString1( "0011" );
    const string theBitString2( "0000" );

    GHDHammingDistance theHammingDistance( theBitString1,
                                           theBitString2 );
    EXPECT_EQ( 2, theHammingDistance.GetDistance() );
}

// ---------------------------------------------------------------------------
TEST( HammingDistanceTest, testBLOB )
{
    const string the64BitString1( "0011001100110011001100110011001100110011001100110011001100110011" );
    const string the64BitString2( "1100110011001100110011001100110011001100110011001100110011001100" );

    GHDHammingDistance theHammingDistance64( the64BitString1,
                                             the64BitString2 );
    EXPECT_EQ( 64, theHammingDistance64.GetDistance() );

    GHDHammingDistance theHammingDistance0( the64BitString1,
                                            the64BitString1 );
    EXPECT_EQ( 0, theHammingDistance0.GetDistance() );
}

}
