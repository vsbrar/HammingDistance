// ===========================================================================
// GHDHammingDistance.h
// ===========================================================================

#ifndef GHDHAMMINGDISTANCE_H
#define GHDHAMMINGDISTANCE_H

#include <string>

#include <boost/dynamic_bitset.hpp>

/**
 * @brief Hamming Distance
 *
 * This class calculates the hamming distance of two bit strings.
 * For more info on hamming distance: https://en.wikipedia.org/wiki/Hamming_distance
 *
 * @note: The bit strings should contain only binary chars.
 */
class GHDHammingDistance
{
public:
    GHDHammingDistance();

    /**
     * @brief Constructor - Accepts two bit strings of equal length
     * @param inBitString1
     * @param inBitString2
     * @throws std::invalid_argument on strings of unequal length
     */
    GHDHammingDistance( const std::string& inBitString1,
                        const std::string& inBitString2 );


    /**
     * @brief Calculates and returns the hamming distance
     * @return The hamming distance
     */
    size_t
    GetDistance() const;

private:
    boost::dynamic_bitset<> mBitSet1;
    boost::dynamic_bitset<> mBitSet2;
};

#endif // GHDHAMMINGDISTANCE_H
