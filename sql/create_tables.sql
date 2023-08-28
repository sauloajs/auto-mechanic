DROP TABLE IF EXISTS `stocks`;
DROP TABLE IF EXISTS `appointments`;
DROP TABLE IF EXISTS `service_order_items`;
DROP TABLE IF EXISTS `parts`;
DROP TABLE IF EXISTS `service_orders`;
DROP TABLE IF EXISTS `vehicles`;
DROP TABLE IF EXISTS `mechanics`;
DROP TABLE IF EXISTS `clients`;

CREATE TABLE clients (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(20),
    last_name VARCHAR(80),
    email VARCHAR(120),
    phone VARCHAR(20),
    PRIMARY KEY (`id`),
    UNIQUE KEY (`email`),
    UNIQUE KEY (`phone`)
);


CREATE TABLE mechanics (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(20),
    last_name VARCHAR(80),
    specialization VARCHAR(100),
    PRIMARY KEY (`id`)
);


CREATE TABLE vehicles (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    client_id INT UNSIGNED NOT NULL,
    brand VARCHAR(40),
    model VARCHAR(100),
    year INT,
    plate VARCHAR(20),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`client_id`) REFERENCES clients (`id`) ON DELETE CASCADE
);

CREATE TABLE service_orders (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    client_id INT UNSIGNED,
    vehicle_id INT UNSIGNED,
    order_date DATE,
    status ENUM ('scheduled', 'in_progress', 'awaiting_parts', 'completed', 'canceled'),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`client_id`) REFERENCES clients (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`vehicle_id`) REFERENCES vehicles (`id`) ON DELETE CASCADE
);

CREATE TABLE parts (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    part_name VARCHAR(255),
    manufacturer VARCHAR(100),
    price DECIMAL(10, 2),
    PRIMARY KEY (`id`)
);

CREATE TABLE service_order_items (
    part_id INT UNSIGNED NOT NULL,
    service_order_id INT UNSIGNED NOT NULL,
    description VARCHAR(255),
    quantity INT,
    unit_price DECIMAL(10, 2),
    KEY (`part_id`),
    FOREIGN KEY (`part_id`) REFERENCES parts (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`service_order_id`) REFERENCES service_orders (`id`) ON DELETE CASCADE,
    PRIMARY KEY (`part_id`, `service_order_id`)
);


CREATE TABLE appointments (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    client_id INT UNSIGNED,
    mechanic_id INT UNSIGNED,
    appointment_date DATETIME,
    notes TEXT,
    FOREIGN KEY (`client_id`) REFERENCES clients (`id`),
    FOREIGN KEY (`mechanic_id`) REFERENCES mechanics(`id`),
    PRIMARY KEY (`id`)
);

CREATE TABLE stocks (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    part_id INT UNSIGNED,
    transaction_type ENUM ('in', 'out'),
    quantity INT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`part_id`) REFERENCES parts (`id`) ON DELETE CASCADE
);