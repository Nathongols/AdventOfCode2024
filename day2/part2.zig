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
    var idx: usize = 1;
    var delete_flag = false;
    while (idx < row.items.len) {
        const prev = row.items[idx - 1];
        const curr = row.items[idx];
        if (inRange(prev, curr)) {
            idx += 1;
            continue;
        }

        if (delete_flag) {
            return false;
        }

        delete_flag = true;
        if (idx + 1 == row.items.len) {
            return true;
        }
        const next = row.items[idx + 1];
        if (inRange(prev, next)) {
            _ = row.orderedRemove(idx);
        } else if (idx >= 2) {
            const pprev = row.items[idx - 2];
            if (inRange(pprev, curr)) {
                _ = row.orderedRemove(idx - 1);
            } else return false;
        } else _ = row.orderedRemove(idx - 1);
    }
    return true;
}

pub fn inRange(x: i32, y: i32) bool {
    return (x > y and x <= y + 3);
}
