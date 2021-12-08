const fs = require('fs');
const nums = fs.readFileSync('input.txt').toString().split("\n");

let prev = null;
let incs = 0;
nums.forEach(n => {
    n = parseInt(n, 10);
    if (prev !== null) {
        if (n > prev) {
            incs++;
        }
    }

    prev = n;
});

console.log(incs);