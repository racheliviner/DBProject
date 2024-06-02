from datetime import datetime, timedelta

# Function to generate sequential dates
def generate_sequential_dates(start_date, num_days):
    return [start_date + timedelta(days=i) for i in range(num_days)]

# Define hours and days
hours = ["14:00", "17:00", "20:00", "23:00"]

# Start date for the records
start_date = datetime(2024, 6, 1)
num_days = 120  # Number of days to generate
total_records = 400  # Total number of unique records to generate

# Generate sequential dates
sequential_dates = generate_sequential_dates(start_date, num_days)

# Calculate how many records per day are needed
records_per_day = total_records // num_days

# Generate 400 unique records
records = []
ur = set()
date_id = 100  # Starting DateID

for day_date in sequential_dates:
    day = day_date.strftime('%a').upper()
    date_d = day_date.strftime('%d-%m-%Y')
    hour_count = 0

    for hour in hours:
        if len(records) >= total_records:
            break
        # Use a tuple to ensure uniqueness
        record = (date_id, hour, day, date_d)
        unique_key = (hour, day, date_d)

        # Add record to the set if the unique combination does not exist
        if unique_key not in ur:
            ur.add(unique_key)
            records.append(record)
            date_id += 1
            hour_count += 1

# Write the insert statements to a SQL file
with open('Date_insertion.sql', 'w') as file:
    for record in records:
        date_id, hour, day, date_d = record
        insert_statement = f"INSERT INTO DATES (DATEID, HOURH, DAYD, DATED) VALUES ({date_id}, '{hour}', '{day}', TO_DATE('{date_d}', 'DD-MM-YYYY'));"
        file.write(insert_statement + '\n')

