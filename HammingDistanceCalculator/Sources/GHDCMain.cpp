// ===========================================================================
// GCITMain.cpp
// ===========================================================================

#include <vector>
#include <string>
#include <iostream>
#include <algorithm>
#include <iterator>

#include <boost/program_options.hpp>

#include "GHDHammingDistance.h"

namespace po = boost::program_options;

// ---------------------------------------------------------------------------
int
main( int argc, char** argv )
{
    // TODO: De clutter return

    // Declare a group of options that will be
    // allowed only on command line
    po::options_description theGenericOptions("Options");
    theGenericOptions.add_options()
        ("help,h", "Help")
        ("bitstrings", po::value<std::vector<std::string>>()->
                multitoken()->required(), "Two bit strings of equal length")
        ("Example:", "\nHammingDistanceCalculator 1100 0011");

    po::positional_options_description thePositionalOptions;
    thePositionalOptions.add("bitstrings", 2);

    po::variables_map theVarMap;

    try
    {
        po::command_line_parser theCommandLineParser{argc, argv};
        theCommandLineParser.options(theGenericOptions).positional(thePositionalOptions).allow_unregistered();
        po::parsed_options theParsedOptions = theCommandLineParser.run();

        po::store(theParsedOptions, theVarMap);

        if( theVarMap.count("help") )
        {
            std::cout << theGenericOptions << std::endl;
            return EXIT_SUCCESS;
        }

        po::notify(theVarMap); // throws on error, so do after help in case
                               // there are any problems

        if( theVarMap.count("bitstrings") )
        {
            auto theBitStrings
            = theVarMap["bitstrings"].as<std::vector<std::string>>();

            // TODO: Check if this can be done via program options
            if ( theBitStrings.size() == 2 )
            {
                std::copy(theBitStrings.begin(), theBitStrings.end(),
                          std::ostream_iterator<std::string>{std::cout, "\n"});

                GHDHammingDistance theHammingDistance( theBitStrings.at(0),
                                                       theBitStrings.at(1) );
                std::cout << "The Hamming Distance: "
                        << theHammingDistance.GetDistance()
                        << std::endl;

                return EXIT_SUCCESS;
            }
            else
            {
                std::cout << theGenericOptions << std::endl;
                return EXIT_FAILURE;
            }
        }
    }
    // TODO: Improve the exceptions handling
    catch( const boost::program_options::required_option& inEx )
    {
        std::cerr << "ERROR: " << inEx.what() << std::endl << std::endl;
        std::cout << theGenericOptions << '\n';
        return EXIT_SUCCESS;
    }
    catch( const boost::program_options::error& inEx )
    {
        std::cerr << "ERROR: " << inEx.what() << std::endl << std::endl;
        std::cout << theGenericOptions << '\n';
        return EXIT_FAILURE;
    }
    catch( const std::exception& inEx )
    {
        std::cerr << "ERROR: " << inEx.what() << std::endl << std::endl;
        std::cout << theGenericOptions << '\n';
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
