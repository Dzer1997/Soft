# database_connection.py

import mysql.connector
from mysql.connector import Error

def get_db_connection():
    try:
        print("🔄 Trying to connect...")  # Debug print

        connection = mysql.connector.connect(
            host='localhost',
            user='root',  # MySQL username
            password='',  # MySQL password
            database='esports_tournament'  # Database name
        )

        if connection.is_connected():
            print(f"✅ Connected successfully as {connection.user}")
            return connection
        else:
            print("❌ Connection failed.")
            return None

    except mysql.connector.Error as e:
        print(f"⚠️ Error: {e}")
        return None

# Kald funktionen for at teste forbindelsen
conn = get_db_connection()

