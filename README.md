# 🚗 Parking Heist Investigation Report

## 📌 Project Overview

This project analyzes a parking database to identify a potential **imposter involved in car theft** and **false statements to police**.

The investigation uses SQL queries to compare:

* Actual parking records
* Payment logs
* Statements provided by individuals

---

## 🗂️ Database Tables Used

* `persons` → Contains user identity details
* `parking_log` → Entry and exit timestamps of vehicles
* `payments` → Payment records for parking
* `statements` → Claims made by individuals

---

## 🎯 Objective

To detect inconsistencies between:

* Claimed parking duration vs actual duration
* Claimed car vs actual car
* Payment records vs parked vehicle

---

## 🛠️ Methodology

### Step 1: Create Investigation View

A combined view was created to merge all relevant data:

```sql
CREATE VIEW parking_log_imposter AS
SELECT 
    p.name,
    p1.car_plate,
    p1.check_in,
    p1.check_out,
    p2.car_plate AS payment_car_plate,
    p2.amount_paid,
    p2.payment_time,
    s1.claimed_car,
    s1.claimed_hours,
    s1.reason
FROM persons p
INNER JOIN parking_log p1 ON p.person_id = p1.person_id
INNER JOIN payments p2 ON p.person_id = p2.person_id
INNER JOIN statements s1 ON p.person_id = s1.person_id;
```

---

## 🔍 Key Investigations

### 1. ⏱️ Mismatch in Parking Duration

```sql
SELECT 
    name, 
    check_in, 
    check_out,
    TIMESTAMPDIFF(HOUR, check_in, check_out) AS actual_hours,
    claimed_hours
FROM parking_log_imposter
WHERE TIMESTAMPDIFF(HOUR, check_in, check_out) != claimed_hours;
```

👉 Detects individuals who lied about parking duration.

---

### 2. 🚘 Mismatch in Car Plate (Payment vs Parking)

```sql
SELECT 
    name, 
    car_plate, 
    payment_car_plate
FROM parking_log_imposter
WHERE car_plate != payment_car_plate;
```

👉 Indicates possible use of another car’s payment.

---

### 3. 🚔 Claimed Car vs Actual Car

```sql
SELECT 
    name, 
    car_plate, 
    claimed_car
FROM parking_log_imposter
WHERE car_plate != claimed_car;
```

👉 Detects false statements given to authorities.

---

##⚠️ Findings

The following suspicious behaviors were observed:

* Individuals reporting incorrect parking duration
* Payments made for different vehicles
* False claims about car ownership

These inconsistencies strongly suggest **fraudulent behavior and potential involvement in theft**.

---

## 🧠 Conclusion

By combining multiple datasets and validating claims against actual records, we successfully identified anomalies that point toward an **imposter**.

This project demonstrates:

* Practical SQL investigation skills
* Data validation techniques
* Real-world fraud detection logic

---




