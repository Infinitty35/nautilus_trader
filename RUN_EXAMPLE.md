# Running the Bybit Sandbox Example

This document explains how to run the `bybit_sandbox.py` example in the Nautilus Trader repository.

## Prerequisites

1. **Build the Package**: The package must be built before running examples.
   ```bash
   make install-just-deps  # Install dependencies
   make build-debug        # Build in debug mode (faster for development)
   ```

2. **Environment Variables**: The Bybit sandbox example requires API credentials to connect to live data.
   - For live trading: Set `BYBIT_API_KEY` and `BYBIT_API_SECRET`
   - For testnet: Set `BYBIT_TESTNET_API_KEY` and `BYBIT_TESTNET_API_SECRET`
   - For demo: Set `BYBIT_DEMO_API_KEY` and `BYBIT_DEMO_API_SECRET`

## Running the Example

### Method 1: Using PYTHONPATH (Recommended after building)
```bash
PYTHONPATH=/path/to/nautilus_trader:$PYTHONPATH .venv/bin/python examples/sandbox/bybit_sandbox.py
```

### Method 2: From the repository root
```bash
cd /home/runner/work/nautilus_trader/nautilus_trader
export PYTHONPATH=/home/runner/work/nautilus_trader/nautilus_trader:$PYTHONPATH
.venv/bin/python examples/sandbox/bybit_sandbox.py
```

## What the Example Does

The `bybit_sandbox.py` example demonstrates:

1. **Sandbox Environment**: Uses real-time market data from Bybit with simulated execution
2. **VolatilityMarketMaker Strategy**: Implements a test market-making strategy
3. **Configuration**:
   - Connects to Bybit for live market data
   - Uses a sandbox execution client for simulated trading
   - Initial balance: 10,000 USDT and 10 ETH
   - Instrument: ETHUSDT-LINEAR perpetual contract
   - Strategy: Volatility-based market making with ATR indicators

## Expected Output

When run successfully (with valid API credentials), you should see:

1. System initialization with specifications
2. Cache and engine initialization
3. Strategy registration (VolatilityMarketMaker)
4. Data client connection to Bybit
5. Execution client (sandbox mode) initialization
6. Live market data processing
7. Strategy execution based on market conditions

## Troubleshooting

### ModuleNotFoundError: No module named 'nautilus_trader'
- **Cause**: Package not built or PYTHONPATH not set correctly
- **Solution**: Build the package with `make build-debug` and set PYTHONPATH

### RuntimeError: Environment variable 'BYBIT_API_KEY' not set
- **Cause**: Required API credentials not provided
- **Solution**: Set the appropriate environment variables with your Bybit API credentials

### Build Errors
- **Solution**: Ensure all system dependencies are installed (Rust, Clang, Python 3.11+)
- Run `make install-just-deps` first, then `make build-debug`

## Build Time

- Initial build (debug mode): ~14-15 minutes
- Subsequent builds: Much faster (only rebuilds changed files)

## Note

⚠️ **This is a test strategy with no alpha advantage whatsoever. It is NOT intended to be used for live trading with real money.**
