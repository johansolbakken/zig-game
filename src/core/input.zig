const std = @import("std");
pub const Mouse = @import("mouse.zig").Mouse;
pub const Key = @import("key.zig").Key;

// bool list of 1024 keys
pub var keys: [1024]bool = .{false} ** 1024;

pub fn isKeyPressed(key: Key) bool {
    return keys[@intFromEnum(key)];
}

pub fn setKeyPressed(key: Key, pressed: bool) void {
    keys[@intFromEnum(key)] = pressed;
}
