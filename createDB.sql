-- Users Table
CREATE SCHEMA expensesTrack;
SET search_path TO expensesTrack;
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at DATE NOT NULL DEFAULT CURRENT_DATE,
    last_logged DATE,
    last_pwd_change DATE,
    password_hash VARCHAR(255) NOT NULL
);

-- Categories Table
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    name VARCHAR(50) NOT NULL,
    icon VARCHAR(100),
    color VARCHAR(20),
    is_default BOOLEAN DEFAULT FALSE,
    is_income BOOLEAN DEFAULT FALSE
);

-- Payment Method Table
CREATE TABLE payment_methods (
    payment_method_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    name VARCHAR(50) NOT NULL,
    type VARCHAR(30) NOT NULL,
    bank_name VARCHAR(100)
);

-- Entry Table
CREATE TABLE entries (
    input_type VARCHAR(20) CHECK (input_type IN ('Text', 'Manual', 'Voice')) PRIMARY KEY,
    input_prompt TEXT,
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER REFERENCES users(user_id)
);

-- Expense Table
CREATE TABLE expenses (
    expense_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    category INTEGER REFERENCES categories(category_id),
    payment_method_id INTEGER REFERENCES payment_methods(payment_method_id),
    amount DECIMAL(10, 2) NOT NULL,
    description TEXT,
    expense_date DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    is_recurring BOOLEAN DEFAULT FALSE,
    receipt VARCHAR(255),
    notes TEXT
);

-- Budgets Table
CREATE TABLE budgets (
    budget_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    category_id INTEGER REFERENCES categories(category_id),
    amount DECIMAL(10, 2) NOT NULL,
    period VARCHAR(20) CHECK (period IN ('Month', 'Day', 'Year')),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);