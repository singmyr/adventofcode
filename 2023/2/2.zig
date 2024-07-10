// https://adventofcode.com/2023/day/2
const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var highest = std.StringHashMap(u8).init(allocator);

    var answer: u64 = 0;

    const reader = std.io.getStdIn().reader();
    var buf: [1000]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        const colonIndex = std.mem.indexOf(u8, line, ":");
        if (colonIndex) |value| {
            if (highest.count() > 0) {
                highest.clearRetainingCapacity();
            }

            var games = std.mem.split(u8, line[value + 2 ..], "; ");
            while (games.next()) |game| {
                var colors = std.mem.split(u8, game, ", ");
                while (colors.next()) |colorString| {
                    const spacePos = std.mem.indexOf(u8, colorString, " ");
                    if (spacePos) |pos| {
                        const amount = try std.fmt.parseInt(u8, colorString[0..pos], 10);
                        const color = colorString[pos + 1 ..];
                        if (highest.get(color)) |low| {
                            if (low <= 0 or amount > low) {
                                try highest.put(color, amount);
                            }
                        } else {
                            try highest.put(color, amount);
                        }
                    }
                }
            }

            const red: u64 = if (highest.get("red")) |v| v else 1;
            const blue: u64 = if (highest.get("blue")) |v| v else 1;
            const green: u64 = if (highest.get("green")) |v| v else 1;
            answer += red * blue * green;
        }
    }

    std.debug.print("{d}\n", .{answer});
}
