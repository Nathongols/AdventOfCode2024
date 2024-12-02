const std = @import("std");
const file = @embedFile("input");
const print = std.debug.print;

const Count = struct {
    num: i64,
    count: i32 = 0,
    fn increment(self: *@This()) void {
        self.count += 1;
    }
};

var lines = std.mem.splitScalar(u8, std.mem.trim(u8, file, "\n"), '\n');

var id = std.heap.GeneralPurposeAllocator(.{}){};
const alloc = id.allocator();

var list_1 = std.ArrayList(i64).init(alloc);
var counts = std.ArrayList(Count).init(alloc);

pub fn main() !void {
    try counts.append(Count{ .num = 0, .count = 0 });

    while (lines.next()) |num| {
        var found: bool = false;
        const temp_num: i64 = try std.fmt.parseInt(i64, num[8..13], 10);
        try list_1.append(try std.fmt.parseInt(i64, num[0..5], 10));
        for (counts.items) |*count| {
            if (count.num == temp_num) {
                count.increment();
                found = true;
                break;
            }
        }
        if (!found) {
            try counts.append(Count{ .num = temp_num, .count = 1 });
        }
    }

    const sliced_1 = try list_1.toOwnedSlice();

    std.mem.sort(i64, sliced_1, {}, comptime std.sort.asc(i64));

    defer alloc.free(sliced_1);

    var simularity: i64 = 0;

    for (sliced_1) |val_1| {
        var val_count: i64 = 0;
        for (counts.items) |count| {
            if (count.num == val_1) {
                val_count = count.count;
                break;
            } else {
                val_count = 0;
            }
        }

        simularity += val_1 * val_count;
    }

    std.debug.print("{}\n", .{simularity});
}
