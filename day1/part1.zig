const std = @import("std");
const file = @embedFile("input");

var lines = std.mem.splitScalar(u8, std.mem.trim(u8, file, "\n"), '\n');

var id = std.heap.GeneralPurposeAllocator(.{}){};
const alloc = id.allocator();

var list_1 = std.ArrayList(i32).init(alloc);
var list_2 = std.ArrayList(i32).init(alloc);

pub fn main() !void {
    while (lines.next()) |num| {
        try list_1.append(try std.fmt.parseInt(i32, num[0..5], 10));
        try list_2.append(try std.fmt.parseInt(i32, num[8..13], 10));
    }

    const sliced_1 = try list_1.toOwnedSlice();
    const sliced_2 = try list_2.toOwnedSlice();

    std.mem.sort(i32, sliced_1, {}, comptime std.sort.asc(i32));
    std.mem.sort(i32, sliced_2, {}, comptime std.sort.asc(i32));

    defer alloc.free(sliced_1);
    defer alloc.free(sliced_2);

    var total_distance: u32 = 0;

    for (sliced_1, sliced_2) |val_1, val_2| {
        total_distance += @abs(val_1 - val_2);
    }

    std.debug.print("{}\n", .{total_distance});
}
