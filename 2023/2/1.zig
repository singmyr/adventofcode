// https://adventofcode.com/2023/day/2
const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var limits = std.StringHashMap(u8).init(allocator);
    try limits.put("red", 12);
    try limits.put("green", 13);
    try limits.put("blue", 14);

    var answer: u64 = 0;

    const reader = std.io.getStdIn().reader();
    var buf: [1000]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        const colonIndex = std.mem.indexOf(u8, line, ":");
        if (colonIndex) |value| {
            var enough = true;
            const gameID = try std.fmt.parseInt(u64, line[5..value], 10);

            var games = std.mem.split(u8, line[value + 2 ..], "; ");
            while (games.next()) |game| {
                var colors = std.mem.split(u8, game, ", ");
                while (colors.next()) |colorString| {
                    const spacePos = std.mem.indexOf(u8, colorString, " ");
                    if (spacePos) |pos| {
                        const amount = try std.fmt.parseInt(u8, colorString[0..pos], 10);
                        const color = colorString[pos + 1 ..];
                        if (limits.get(color)) |limit| {
                            if (amount > limit) {
                                enough = false;
                            }
                        }
                    }
                }
            }
            if (enough) {
                answer += gameID;
            }
        }
    }

    std.debug.print("{d}\n", .{answer});
}
