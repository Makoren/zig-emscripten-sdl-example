const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = std.zig.CrossTarget{ .cpu_arch = .wasm32, .os_tag = .emscripten };

    const lib = b.addStaticLibrary(.{
        .name = "sdl-test",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = .Debug,
    });
    lib.linkLibC();
    lib.addIncludePath(.{ .path = "/Users/mak/dev/_SDKs/emsdk/upstream/emscripten/cache/sysroot/include" });
    b.installArtifact(lib);
}
