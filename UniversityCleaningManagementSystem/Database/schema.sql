/*Contains only the commands that create the database structure.*/
/*users table*/
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,  -- stores "salt:hash"
    role VARCHAR(20) NOT NULL CHECK (role IN ('Storekeeper', 'Supervisor'))
);

/*cleaners table*/
CREATE TABLE cleaners (
    cleaner_id      INT AUTO_INCREMENT PRIMARY KEY,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    contact_number  VARCHAR(20),
    email           VARCHAR(100),
    department      VARCHAR(50),
    status          VARCHAR(20)  DEFAULT 'Active',
    date_added      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

/*materials table*/

/*suppliers table*/

/*stock issurance table*/


