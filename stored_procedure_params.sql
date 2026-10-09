-- ============================================
-- BÀI THỰC HÀNH: STORED PROCEDURE VỚI THAM SỐ
-- Database: classicmodels
-- ============================================

USE classicmodels;

-- ============================================
-- PHẦN 1: THAM SỐ IN
-- ============================================

DROP PROCEDURE IF EXISTS getCusById;

DELIMITER //

CREATE PROCEDURE getCusById(IN cusNum INT(11))
BEGIN
    SELECT * FROM customers WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Gọi Procedure
CALL getCusById(175);

-- ============================================
-- PHẦN 2: THAM SỐ OUT
-- ============================================

DROP PROCEDURE IF EXISTS GetCustomersCountByCity;

DELIMITER //

CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Gọi Procedure
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total AS 'Số khách hàng ở Lyon';

-- ============================================
-- PHẦN 3: THAM SỐ INOUT
-- ============================================

DROP PROCEDURE IF EXISTS SetCounter;

DELIMITER //

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Gọi Procedure nhiều lần
SET @counter = 1;

CALL SetCounter(@counter, 1);
SELECT @counter AS 'Sau lần 1';

CALL SetCounter(@counter, 1);
SELECT @counter AS 'Sau lần 2';

CALL SetCounter(@counter, 5);
SELECT @counter AS 'Sau lần 3 (cuối)';

-- ============================================
-- PHẦN 4: XEM DANH SÁCH PROCEDURE
-- ============================================
SHOW PROCEDURE STATUS WHERE db = 'classicmodels';