import pyodbc


server = 'DESKTOP-MKB86PI'    
database = 'StudentRecords'     
driver = 'ODBC Driver 17 for SQL Server'

# Connection string for Windows Authentication
connection_string = f"""
    DRIVER={{{driver}}};
    SERVER={server};
    DATABASE={database};
    Trusted_Connection=yes;
    TrustServerCertificate=yes;
"""

def get_connection():
    try:
        conn = pyodbc.connect(connection_string)
        return conn
    except Exception as e:
        print("❌ Failed to connect to database:", e)
        return None
