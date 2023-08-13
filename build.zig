const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "zig-game",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    exe.linkSystemLibrary("glfw3");
    exe.addIncludePath(.{ .path = "src" });
    exe.addIncludePath(.{ .path = "vendor/glfw/include" });
    exe.addIncludePath(.{ .path = "vendor/glad/include" });
    exe.addCSourceFile(.{ .file = .{ .path = "src/platform/opengl/glinit.c" }, .flags = &[_][]const u8{} });
    exe.addCSourceFile(.{ .file = .{ .path = "vendor/glad/src/glad.c" }, .flags = &[_][]const u8{} });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
