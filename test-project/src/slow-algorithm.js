// This file contains intentional performance issues for testing

// PERFORMANCE ISSUE 1: O(n²) algorithm
function findDuplicates(array) {
    const duplicates = [];
    for (let i = 0; i < array.length; i++) {
        for (let j = i + 1; j < array.length; j++) {
            if (array[i] === array[j] && !duplicates.includes(array[i])) {
                duplicates.push(array[i]);
            }
        }
    }
    return duplicates;
}

// PERFORMANCE ISSUE 2: Synchronous file operations in loop
function processFiles(filenames) {
    const fs = require('fs');
    const results = [];
    
    filenames.forEach(filename => {
        const content = fs.readFileSync(filename, 'utf8'); // Sync I/O in loop
        const processed = content.toUpperCase();
        fs.writeFileSync(filename + '.processed', processed); // Sync write
        results.push(processed);
    });
    
    return results;
}

// PERFORMANCE ISSUE 3: Memory leak
let cache = {};
function addToCache(key, value) {
    cache[key] = value; // Never cleared, grows indefinitely
    // No cache size limit or eviction policy
}

// PERFORMANCE ISSUE 4: Inefficient string concatenation
function buildLargeString(items) {
    let result = '';
    for (const item of items) {
        result += item + ', '; // String concatenation in loop
    }
    return result;
}

// PERFORMANCE ISSUE 5: N+1 database queries
async function getUsersWithPosts(db) {
    const users = await db.query('SELECT * FROM users');
    
    for (const user of users) {
        user.posts = await db.query(`SELECT * FROM posts WHERE user_id = ${user.id}`); // N+1 queries
    }
    
    return users;
}

// PERFORMANCE ISSUE 6: Blocking event loop
function calculatePrimes(max) {
    const primes = [];
    for (let i = 2; i <= max; i++) {
        let isPrime = true;
        for (let j = 2; j < i; j++) {
            if (i % j === 0) {
                isPrime = false;
                break;
            }
        }
        if (isPrime) primes.push(i);
    }
    return primes; // CPU-intensive, blocks event loop
}

// PERFORMANCE ISSUE 7: Inefficient array operations
function removeItems(array, itemsToRemove) {
    itemsToRemove.forEach(item => {
        const index = array.indexOf(item);
        if (index > -1) {
            array.splice(index, 1); // Splice in loop is O(n²)
        }
    });
    return array;
}

// PERFORMANCE ISSUE 8: Unnecessary re-renders (React-like)
function Component({ data }) {
    // Creating new objects/arrays on every render
    const processedData = data.map(item => ({ ...item, processed: true }));
    const filteredData = processedData.filter(item => item.active);
    
    return filteredData;
}

// PERFORMANCE ISSUE 9: Deep object cloning
function deepClone(obj) {
    return JSON.parse(JSON.stringify(obj)); // Inefficient for large objects
}

// PERFORMANCE ISSUE 10: Regex in hot path
function validateEmail(emails) {
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Regex compiled on each call
    return emails.filter(email => regex.test(email));
}

module.exports = {
    findDuplicates,
    processFiles,
    addToCache,
    buildLargeString,
    getUsersWithPosts,
    calculatePrimes,
    removeItems,
    deepClone,
    validateEmail
};