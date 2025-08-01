// This file contains legacy code with multiple issues for refactoring

// CODE SMELL 1: God class - doing too many things
class UserManager {
    constructor() {
        this.users = [];
        this.sessions = {};
        this.logs = [];
        this.emailQueue = [];
        this.notifications = [];
        this.cache = {};
    }

    // CODE SMELL 2: Long method with multiple responsibilities
    processUserRegistration(userData) {
        // Validate user data
        if (!userData.email || !userData.password) {
            return { error: 'Missing required fields' };
        }
        
        if (userData.password.length < 8) {
            return { error: 'Password too short' };
        }
        
        if (!userData.email.includes('@')) {
            return { error: 'Invalid email' };
        }
        
        // Check if user exists
        const existingUser = this.users.find(u => u.email === userData.email);
        if (existingUser) {
            return { error: 'User already exists' };
        }
        
        // Create user
        const newUser = {
            id: this.users.length + 1,
            email: userData.email,
            password: userData.password, // CODE SMELL 3: Storing plain text password
            createdAt: new Date(),
            profile: {
                name: userData.name || '',
                age: userData.age || 0,
                address: userData.address || ''
            }
        };
        
        // Add to users array
        this.users.push(newUser);
        
        // Send welcome email
        this.emailQueue.push({
            to: newUser.email,
            subject: 'Welcome!',
            body: 'Welcome to our platform'
        });
        
        // Log the action
        this.logs.push({
            action: 'USER_REGISTERED',
            userId: newUser.id,
            timestamp: new Date()
        });
        
        // Create session
        const sessionId = Math.random().toString(36);
        this.sessions[sessionId] = {
            userId: newUser.id,
            createdAt: new Date()
        };
        
        // Clear cache
        this.cache = {};
        
        return { success: true, sessionId, userId: newUser.id };
    }

    // CODE SMELL 4: Feature envy - method uses data from other object more than its own
    calculateUserScore(userId, purchaseHistory, activityLog, socialData) {
        let score = 0;
        
        // Uses purchaseHistory extensively
        purchaseHistory.forEach(purchase => {
            score += purchase.amount * 0.1;
            if (purchase.category === 'premium') {
                score += 50;
            }
            if (purchase.referredBy) {
                score += 20;
            }
        });
        
        // Uses activityLog extensively
        activityLog.forEach(activity => {
            if (activity.type === 'login') {
                score += 1;
            }
            if (activity.type === 'share') {
                score += 5;
            }
            if (activity.type === 'review') {
                score += 10;
            }
        });
        
        // Uses socialData extensively
        score += socialData.followers * 0.5;
        score += socialData.following * 0.1;
        score += socialData.posts * 2;
        
        return score;
    }

    // CODE SMELL 5: Duplicate code
    sendEmail(to, subject, body) {
        // Validation logic duplicated
        if (!to || !to.includes('@')) {
            return false;
        }
        
        this.emailQueue.push({
            to: to,
            subject: subject,
            body: body,
            timestamp: new Date()
        });
        
        return true;
    }

    sendBulkEmail(recipients, subject, body) {
        // Validation logic duplicated
        recipients.forEach(to => {
            if (!to || !to.includes('@')) {
                return;
            }
            
            this.emailQueue.push({
                to: to,
                subject: subject,
                body: body,
                timestamp: new Date()
            });
        });
    }

    // CODE SMELL 6: Long parameter list
    createUserProfile(id, name, email, age, address, phone, country, zipcode, preferences, settings) {
        return {
            id, name, email, age, address, phone, country, zipcode, preferences, settings
        };
    }

    // CODE SMELL 7: Inappropriate intimacy - knows too much about User internals
    updateUserInternals(user) {
        user._internal = {
            lastModified: new Date(),
            version: (user._internal?.version || 0) + 1,
            checksum: this.calculateChecksum(user)
        };
        user._cache = null;
        user._dirty = true;
    }

    // CODE SMELL 8: Dead code
    oldValidationMethod(data) {
        // This method is never called
        console.log('Validating...', data);
        return true;
    }

    // CODE SMELL 9: Speculative generality
    abstractDataProcessor(data, options = {}) {
        const { 
            preProcess = x => x,
            postProcess = x => x,
            middleware = [],
            errorHandler = e => { throw e; },
            timeout = 5000,
            retries = 3,
            cacheResult = false
        } = options;
        
        // Overly complex for current needs
        try {
            let result = preProcess(data);
            middleware.forEach(m => { result = m(result); });
            result = this.process(result);
            return postProcess(result);
        } catch (e) {
            return errorHandler(e);
        }
    }
}

// CODE SMELL 10: Global state
var globalUserManager = new UserManager();
var globalConfig = {
    apiKey: 'secret-key',
    environment: 'production'
};

// CODE SMELL 11: Magic numbers
function calculateShipping(weight, distance) {
    if (weight < 5) {
        return distance * 0.5;
    } else if (weight < 20) {
        return distance * 0.8;
    } else {
        return distance * 1.2;
    }
}

// CODE SMELL 12: Inconsistent naming
const usr_count = 100;
const UserCount = 100;
const USERCOUNT = 100;

module.exports = {
    UserManager,
    globalUserManager,
    calculateShipping
};