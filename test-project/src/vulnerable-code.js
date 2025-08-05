// This file contains intentional security vulnerabilities for testing

const express = require('express');
const mysql = require('mysql');
const fs = require('fs');

// VULNERABILITY 1: SQL Injection
function getUserById(userId) {
    const query = `SELECT * FROM users WHERE id = ${userId}`; // Direct string concatenation
    return database.query(query);
}

// VULNERABILITY 2: XSS - No input sanitization
function renderUserProfile(req, res) {
    const username = req.query.username;
    res.send(`<h1>Welcome ${username}</h1>`); // Direct HTML injection
}

// VULNERABILITY 3: Path Traversal
function readUserFile(req, res) {
    const filename = req.query.file;
    const content = fs.readFileSync(`./uploads/${filename}`); // No path validation
    res.send(content);
}

// VULNERABILITY 4: Hardcoded credentials
const API_KEY = "sk-1234567890abcdef"; // Hardcoded API key
const DB_PASSWORD = "admin123"; // Hardcoded password

// VULNERABILITY 5: Insecure Random
function generateToken() {
    return Math.random().toString(36).substring(7); // Predictable randomness
}

// VULNERABILITY 6: Command Injection
function processUserInput(userInput) {
    const exec = require('child_process').exec;
    exec(`echo ${userInput}`); // Direct command execution
}

// VULNERABILITY 7: Missing Authentication
app.get('/admin/users', (req, res) => {
    // No authentication check
    res.json(getAllUsers());
});

// VULNERABILITY 8: Sensitive Data Exposure
function logError(error, userData) {
    console.log('Error occurred:', error);
    console.log('User data:', userData); // Logging sensitive information
}

// VULNERABILITY 9: CORS Misconfiguration
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*'); // Allow all origins
    res.header('Access-Control-Allow-Credentials', 'true');
    next();
});

// VULNERABILITY 10: Weak Crypto
const crypto = require('crypto');
function hashPassword(password) {
    return crypto.createHash('md5').update(password).digest('hex'); // Weak hashing
}

module.exports = {
    getUserById,
    renderUserProfile,
    readUserFile,
    generateToken,
    processUserInput,
    hashPassword
};