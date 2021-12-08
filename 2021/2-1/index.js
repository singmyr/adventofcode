const fs = require('fs');
const directions = fs.readFileSync('input.txt').toString().split("\n").map(n => {
    const parts = n.split(" ");
    return [parts[0], parseInt(parts[1], 10)];
});

let pos = 0;
let depth = 0;

directions.forEach(n => {
    switch(n[0]) {
        case 'forward':
            pos += n[1];
            break;
        case 'up':
            depth -= n[1];
            break;
        case 'down':
            depth += n[1];
            break;
    }
});

console.log(pos * depth);