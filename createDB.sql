-- Create users table
CREATE TABLE users (
	userID SERIAL PRIMARY KEY,
	userName VARCHAR(50) UNIQUE NOT NULL,
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	createdAt DATE NOT NULL DEFAULT CURRENT_DATE,
	lastLogged DATE,
	lastPWDChange DATE,
	passwordHash VARCHAR(255) NOT NULL
);

-- Create Categories table


