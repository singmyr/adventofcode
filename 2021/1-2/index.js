const fs = require('fs');
const nums = fs.readFileSync('input.txt').toString().split("\n").map(n => parseInt(n, 10));

let prev = null;
let incs = 0;

for(let i = 2; i < nums.length; i++) {
    const sum = nums[i-2] + nums[i-1] + nums[i];
    if (prev !== null) {
        if (sum > prev) {
            incs++;
        }
    }

    prev = sum;
}

console.log(incs);