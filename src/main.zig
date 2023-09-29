const std = @import("std");
const RndGen = std.rand.DefaultPrng;

const sdl = @cImport({
    @cInclude("stdlib.h");
    @cInclude("emscripten.h");
    @cInclude("SDL/SDL.h");
});

var rnd = RndGen.init(0);
var screen: ?*sdl.SDL_Surface = null;

fn drawRandomPixels() callconv(.C) void {
    if (sdl.SDL_MUSTLOCK(screen) == sdl.SDL_TRUE) {
        _ = sdl.SDL_LockSurface(screen);
    }

    const pixels: [*]u8 = @ptrCast(screen.?.pixels);

    var i: u32 = 0;
    while (i < 1048576) : (i += 1) {
        const randomByte: u8 = rnd.random().int(u8);
        pixels[i] = randomByte;
    }

    if (sdl.SDL_MUSTLOCK(screen) == sdl.SDL_TRUE) {
        _ = sdl.SDL_UnlockSurface(screen);
    }

    _ = sdl.SDL_Flip(screen);
}

pub export fn appInit() void {
    if (sdl.SDL_Init(sdl.SDL_INIT_VIDEO) < 0) {
        std.debug.print("{s}\n", .{sdl.SDL_GetError()});
        return;
    }

    const stdout = std.io.getStdOut().writer();
    stdout.print("Hello from Zig!\n", .{}) catch return;

    screen = sdl.SDL_SetVideoMode(512, 512, 32, sdl.SDL_SWSURFACE);

    sdl.emscripten_set_main_loop(drawRandomPixels, 0, 1);
}
