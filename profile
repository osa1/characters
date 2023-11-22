#!/bin/bash

set -e
set -x

perf record -g -o benchmark.wasm.perf -F 999 $DART_SDK/../third_party/d8/linux/x64/d8 --perf-basic-prof --turboshaft-wasm --experimental-wasm-imported-strings $DART_SDK/../pkg/dart2wasm/bin/run_wasm.js -- `readlink -f benchmark.mjs` benchmark.wasm

perf script -F +pid -i benchmark.wasm.perf > benchmark.wasm.script.perf

perf record -g -o benchmark.js.perf -F 999 $DART_SDK/../third_party/d8/linux/x64/d8 --perf-basic-prof $DART_SDK/lib/_internal/js_runtime/lib/preambles/d8.js benchmark.js

perf script -F +pid -i benchmark.js.perf > benchmark.js.script.perf
