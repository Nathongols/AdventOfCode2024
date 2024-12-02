const std = @import("std");
const print = std.debug.print;
const file = @embedFile("input");

const lines = std.mem.splitSequence(u8, file, "  ");
const list_1: []const u8 = &lines.next();
const list_2: []const u8 = undefined;

pub fn main() void {
    print("{c}\n", .{list_1});
}
