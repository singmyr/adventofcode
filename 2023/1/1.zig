// https://adventofcode.com/2023/day/1
const std = @import("std");

pub fn getNumber(char: u8) u8 {
    return char - 48;
}

pub fn main() !void {
    var sum: u64 = 0;

    const reader = std.io.getStdIn().reader();
    var buf: [1000]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        // Find the first number
        sum += (for (line) |c| {
            const numerical = getNumber(c);
            if (numerical <= 9) {
                break numerical;
            }
        } else 0) * 10;

        // Find the last number
        sum += for (0..line.len) |i| {
            const numerical = getNumber(line[line.len - 1 - i]);
            if (numerical <= 9) {
                break numerical;
            }
        } else 0;
    }

    std.debug.print("{d}\n", .{sum});
}
