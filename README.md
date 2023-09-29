# zig-emscripten-sdl-example
An example of an Emscripten application drawing to the canvas with SDL2. The majority of the code is written in Zig.

Uses the Zig build system to compile the Zig code into a static library and links it with `emcc`. A minimal C program is used to run the library code.

The Zig code has been ported from [this C example](https://www.jamesfmackenzie.com/2019/12/01/webassembly-graphics-with-sdl/).

## Usage
Assuming you have Emscripten set up and in your PATH, run the following commands:
```
source emsdk_env.sh
zig build
cd build
emcc main.c -Lzig-out/lib -lsdl-test -o build/index.html -s USE_SDL=1
```
Then open the `build` directory and serve the files from a web server to view the app. I'm partial to [live-server](https://www.npmjs.com/package/live-server).
