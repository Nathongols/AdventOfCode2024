const std = @import("std");
const print = std.debug.print;

const file = @embedFile("input");

var lines = std.mem.splitScalar(u8, std.mem.trim(u8, file, "\n"), '\n');

var unga = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = unga.allocator();

var num_list = std.ArrayList(i32).init(allocator);

pub fn main() !void {
    var safe_lines: u16 = 0;

    while (lines.next()) |line| {
        //Forward pass
        num_list.clearRetainingCapacity();
        var byte_row = std.mem.splitScalar(u8, line, ' ');

        while (byte_row.next()) |byte| {
            try num_list.append(try std.fmt.parseInt(i32, byte, 10));
        }
        safe_lines += @intFromBool(check(&num_list));

        //Backward pass
        num_list.clearRetainingCapacity();
        var rev_byte_row = std.mem.splitBackwardsScalar(u8, line, ' ');

        while (rev_byte_row.next()) |byte| {
            try num_list.append(try std.fmt.parseInt(i32, byte, 10));
        }

        safe_lines += @intFromBool(check(&num_list));
    }

    print("{}\n", .{safe_lines});
}

pub fn check(row: *std.ArrayList(i32)) bool {
    for (0..row.items.len, row.items) |i, curr| {
        if (i != 0) {
            const prev = row.items[i - 1];
            if (inRange(prev, curr)) {
                continue;
            }
            return false;
        }
    }
    return true;
}

pub fn inRange(x: i32, y: i32) bool {
    return (x > y and x <= y + 3);
}
