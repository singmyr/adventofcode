// https://adventofcode.com/2023/day/1
const std = @import("std");

pub fn getNumber(char: u8) u8 {
    return char - 48;
}

pub fn cmpString(a: []const u8, b: []u8) bool {
    if (a.len != b.len) {
        return false;
    }

    return for (a, 0..) |c, i| {
        if (c != b[i]) {
            break false;
        }
    } else true;
}

pub fn main() !void {
    var sum: u64 = 0;

    const reader = std.io.getStdIn().reader();
    var buf: [1000]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        // Find the first number
        sum += (for (line, 0..) |c, i| {
            const numerical = getNumber(c);
            if (numerical <= 9) {
                break numerical;
            } else {
                switch (c) {
                    'o' => {
                        // one
                        if (i + 2 < line.len and cmpString("one", line[i .. i + 3])) {
                            break 1;
                        }
                    },
                    't' => {
                        // two
                        if (i + 2 < line.len and cmpString("two", line[i .. i + 3])) {
                            break 2;
                        }
                        // three
                        if (i + 4 < line.len and cmpString("three", line[i .. i + 5])) {
                            break 3;
                        }
                    },
                    'f' => {
                        // four
                        if (i + 3 < line.len and cmpString("four", line[i .. i + 4])) {
                            break 4;
                        }
                        // five
                        if (i + 4 < line.len and cmpString("five", line[i .. i + 4])) {
                            break 5;
                        }
                    },
                    's' => {
                        // six
                        if (i + 2 < line.len and cmpString("six", line[i .. i + 3])) {
                            break 6;
                        }
                        // seven
                        if (i + 4 < line.len and cmpString("seven", line[i .. i + 5])) {
                            break 7;
                        }
                    },
                    'e' => {
                        // eight
                        if (i + 4 < line.len and cmpString("eight", line[i .. i + 5])) {
                            break 8;
                        }
                    },
                    'n' => {
                        // nine
                        if (i + 3 < line.len and cmpString("nine", line[i .. i + 4])) {
                            break 9;
                        }
                    },
                    else => {},
                }
            }
        } else 0) * 10;

        // Find the last number
        sum += for (0..line.len) |i| {
            const curPos = line.len - 1 - i;
            const c = line[curPos];
            const numerical = getNumber(c);
            if (numerical <= 9) {
                break numerical;
            } else {
                switch (c) {
                    'o' => {
                        // one
                        if (curPos + 2 < line.len and cmpString("one", line[curPos .. curPos + 3])) {
                            break 1;
                        }
                    },
                    't' => {
                        // two
                        if (curPos + 2 < line.len and cmpString("two", line[curPos .. curPos + 3])) {
                            break 2;
                        }
                        // three
                        if (curPos + 4 < line.len and cmpString("three", line[curPos .. curPos + 5])) {
                            break 3;
                        }
                    },
                    'f' => {
                        // four
                        if (curPos + 3 < line.len and cmpString("four", line[curPos .. curPos + 4])) {
                            break 4;
                        }
                        // five
                        if (curPos + 3 < line.len and cmpString("five", line[curPos .. curPos + 4])) {
                            break 5;
                        }
                    },
                    's' => {
                        // six
                        if (curPos + 2 < line.len and cmpString("six", line[curPos .. curPos + 3])) {
                            break 6;
                        }
                        // seven
                        if (curPos + 4 < line.len and cmpString("seven", line[curPos .. curPos + 5])) {
                            break 7;
                        }
                    },
                    'e' => {
                        // eight
                        if (curPos + 4 < line.len and cmpString("eight", line[curPos .. curPos + 5])) {
                            break 8;
                        }
                    },
                    'n' => {
                        // nine
                        if (curPos + 3 < line.len and cmpString("nine", line[curPos .. curPos + 4])) {
                            break 9;
                        }
                    },
                    else => {},
                }
            }
        } else 0;
    }

    std.debug.print("{d}\n", .{sum});
}
