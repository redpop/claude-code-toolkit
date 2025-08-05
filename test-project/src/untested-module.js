// This file has no test coverage for testing the test generation commands

class ShoppingCart {
    constructor() {
        this.items = [];
        this.discounts = [];
    }

    // No tests for this method
    addItem(product, quantity = 1) {
        const existingItem = this.items.find(item => item.product.id === product.id);
        
        if (existingItem) {
            existingItem.quantity += quantity;
        } else {
            this.items.push({ product, quantity });
        }
    }

    // No tests for this method
    removeItem(productId) {
        const index = this.items.findIndex(item => item.product.id === productId);
        if (index > -1) {
            this.items.splice(index, 1);
        }
    }

    // No tests for this method
    updateQuantity(productId, quantity) {
        const item = this.items.find(item => item.product.id === productId);
        if (item) {
            if (quantity <= 0) {
                this.removeItem(productId);
            } else {
                item.quantity = quantity;
            }
        }
    }

    // No tests for this method
    applyDiscount(discountCode) {
        const discount = this.validateDiscount(discountCode);
        if (discount && !this.discounts.includes(discount)) {
            this.discounts.push(discount);
        }
    }

    // No tests for this method
    validateDiscount(code) {
        const validDiscounts = {
            'SAVE10': { type: 'percentage', value: 10 },
            'SAVE20': { type: 'percentage', value: 20 },
            'FLAT5': { type: 'fixed', value: 5 },
            'FREESHIP': { type: 'shipping', value: 0 }
        };
        return validDiscounts[code];
    }

    // No tests for this method
    calculateSubtotal() {
        return this.items.reduce((total, item) => {
            return total + (item.product.price * item.quantity);
        }, 0);
    }

    // No tests for this method
    calculateDiscount() {
        const subtotal = this.calculateSubtotal();
        let totalDiscount = 0;

        this.discounts.forEach(discount => {
            if (discount.type === 'percentage') {
                totalDiscount += subtotal * (discount.value / 100);
            } else if (discount.type === 'fixed') {
                totalDiscount += discount.value;
            }
        });

        return Math.min(totalDiscount, subtotal);
    }

    // No tests for this method
    calculateTotal() {
        const subtotal = this.calculateSubtotal();
        const discount = this.calculateDiscount();
        const shipping = this.calculateShipping();
        const tax = this.calculateTax(subtotal - discount);
        
        return subtotal - discount + shipping + tax;
    }

    // No tests for this method
    calculateShipping() {
        const hasFreeSHipping = this.discounts.some(d => d.type === 'shipping');
        if (hasFreeSHipping) return 0;

        const subtotal = this.calculateSubtotal();
        if (subtotal > 50) return 0;
        if (subtotal > 25) return 5;
        return 10;
    }

    // No tests for this method
    calculateTax(amount) {
        const TAX_RATE = 0.08; // 8% tax
        return amount * TAX_RATE;
    }

    // No tests for this method
    isEmpty() {
        return this.items.length === 0;
    }

    // No tests for this method
    getItemCount() {
        return this.items.reduce((count, item) => count + item.quantity, 0);
    }

    // No tests for this method
    clear() {
        this.items = [];
        this.discounts = [];
    }
}

// Utility functions also without tests
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(amount);
}

function validateProduct(product) {
    return product && 
           product.id && 
           product.name && 
           typeof product.price === 'number' && 
           product.price >= 0;
}

function generateOrderId() {
    return 'ORD-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
}

module.exports = {
    ShoppingCart,
    formatCurrency,
    validateProduct,
    generateOrderId
};