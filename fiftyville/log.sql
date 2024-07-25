-- Keep a log of any SQL queries you execute as you solve the mystery.
--Crime Scene Reports
SELECT * FROM crime_scene_reports WHERE street = 'Humphrey Street';

--Bakery Witnesses
SELECT * FROM interviews WHERE transcript LIKE '%bakery%';

--Witnesses 1 ruth
SELECT * FROM bakery_security_logs WHERE year = 2023 AND month = 7 AND day = 28 AND hour = 10 AND minute BETWEEN 15 AND 25;

--Check Against License Plates
SELECT p.name, bsl.activity, bsl.license_plate, bsl.year, bsl.month, bsl.day, bsl.hour, bsl.minute
FROM bakery_security_logs bsl
JOIN people p ON p.license_plate = bsl.license_plate
WHERE bsl.year = 2023 AND bsl.month = 7 AND bsl.day = 28 AND bsl.hour = 10 AND bsl.minute BETWEEN 15 AND 25;

--Witness 2 (ATM Transactions)
SELECT * FROM atm_transactions WHERE atm_location = 'Leggett Street' AND year = 2023 AND month = 7 AND day = 28;

--Add Name of Withdraw from ATM
SELECT a.*, p.name
FROM atm_transactions a
JOIN bank_accounts b ON a.account_number = b.account_number
JOIN people p ON b.person_id = p.id
WHERE a.atm_location = 'Leggett Street' AND a.year = 2023 AND a.month = 7 AND a.day = 28 AND a.transaction_type = 'withdraw';

--Witness 3 Phone Call Investigation
SELECT * FROM phone_calls WHERE year = 2023 AND month = 7 AND day = 28 AND duration < 60;

--Add Name to List of Callers
SELECT p.name, pc.caller, pc.receiver, pc.year, pc.month, pc.day, pc.duration
FROM phone_calls pc
JOIN people p ON pc.caller = p.phone_number
WHERE pc.year = 2023 AND pc.month = 7 AND pc.day = 28 AND pc.duration < 60;

-- Explore Airport to Find Fiftyville
SELECT * FROM airports;

--Flights Out of Fiftyville id(8)
SELECT f.*, origin.full_name AS origin_airport, destination.full_name AS destination_airport
FROM flights f
JOIN airports origin ON f.origin_airport_id = origin.id
JOIN airports destination ON f.destination_airport_id = destination.id
WHERE origin.id = 8 AND f.year = 2023 AND f.month = 7 AND f.day = 29
ORDER BY f.hour, f.minute;

--Combine Info from All Three Testimonies
SELECT p.name
FROM bakery_security_logs bsl
JOIN people p ON p.license_plate = bsl.license_plate
JOIN bank_accounts ba ON ba.person_id = p.id
JOIN atm_transactions at ON at.account_number = ba.account_number
JOIN phone_calls pc ON pc.caller = p.phone_number
WHERE bsl.year = 2023 AND bsl.month = 7 AND bsl.day = 28 AND bsl.hour = 10 AND bsl.minute BETWEEN 15 AND 25
AND at.atm_location = 'Leggett Street' AND at.year = 2023 AND at.month = 7 AND at.day = 28 AND at.transaction_type = 'withdraw'
AND pc.year = 2023 AND pc.month = 7 AND pc.day = 28 AND pc.duration < 60;

--Narrow Down from Bruce/Diana Who is on Flight
SELECT p.name
FROM people p
JOIN passengers ps ON p.passport_number = ps.passport_number
WHERE ps.flight_id = 36
AND p.name IN ('Bruce', 'Diana');

--Who Did Bruce Call
SELECT p2.name AS receiver
FROM phone_calls pc
JOIN people p1 ON pc.caller = p1.phone_number
JOIN people p2 ON pc.receiver = p2.phone_number
WHERE p1.name = 'Bruce' AND pc.year = 2023 AND pc.month = 7 AND pc.day = 28 AND pc.duration < 60;
