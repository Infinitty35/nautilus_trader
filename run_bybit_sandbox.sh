#!/bin/bash
# Script to run the Bybit Sandbox example
# This script helps run the bybit_sandbox.py example with proper environment setup

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}==================================================================${NC}"
echo -e "${GREEN}Nautilus Trader - Bybit Sandbox Example Runner${NC}"
echo -e "${GREEN}==================================================================${NC}"
echo ""

# Get the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Check if build exists
if [ ! -d "nautilus_trader/core" ] || [ ! -f "nautilus_trader/core/data.*.so" ]; then
    echo -e "${YELLOW}Warning: Package may not be built yet.${NC}"
    echo -e "${YELLOW}Building the package in debug mode (this will take ~15 minutes)...${NC}"
    echo ""
    make install-just-deps
    make build-debug
    echo ""
    echo -e "${GREEN}Build completed successfully!${NC}"
    echo ""
fi

# Check for API credentials
if [ -z "$BYBIT_API_KEY" ] && [ -z "$BYBIT_TESTNET_API_KEY" ] && [ -z "$BYBIT_DEMO_API_KEY" ]; then
    echo -e "${YELLOW}==================================================================${NC}"
    echo -e "${YELLOW}WARNING: No Bybit API credentials found!${NC}"
    echo -e "${YELLOW}==================================================================${NC}"
    echo ""
    echo "The Bybit sandbox example requires API credentials to connect to live data."
    echo "You can set one of the following environment variables:"
    echo ""
    echo "  For live trading (NOT RECOMMENDED for testing):"
    echo "    export BYBIT_API_KEY=\"your_key_here\""
    echo "    export BYBIT_API_SECRET=\"your_secret_here\""
    echo ""
    echo "  For testnet (recommended for testing):"
    echo "    export BYBIT_TESTNET_API_KEY=\"your_key_here\""
    echo "    export BYBIT_TESTNET_API_SECRET=\"your_secret_here\""
    echo ""
    echo "  For demo account:"
    echo "    export BYBIT_DEMO_API_KEY=\"your_key_here\""
    echo "    export BYBIT_DEMO_API_SECRET=\"your_secret_here\""
    echo ""
    echo -e "${YELLOW}The script will attempt to run but will fail when connecting to Bybit.${NC}"
    echo ""
    read -p "Press Enter to continue anyway, or Ctrl+C to cancel..."
    echo ""
fi

# Set PYTHONPATH
export PYTHONPATH="${SCRIPT_DIR}:${PYTHONPATH}"

echo -e "${GREEN}Starting Bybit Sandbox Example...${NC}"
echo ""
echo "Using PYTHONPATH: $PYTHONPATH"
echo ""

# Run the example
if [ -f ".venv/bin/python" ]; then
    .venv/bin/python examples/sandbox/bybit_sandbox.py
else
    echo -e "${RED}Error: Virtual environment not found. Please run 'make install-just-deps' first.${NC}"
    exit 1
fi
