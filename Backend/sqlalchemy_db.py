from sqlalchemy import create_engine

# Replace with your actual credentials
server = 'DESKTOP-MKB86PI'    
database = 'StudentRecords'     
driver = 'ODBC Driver 17 for SQL Server'

connection_string = (
    f"mssql+pyodbc://{username}:{password}@{server}/{database}"
    "?driver=ODBC+Driver+17+for+SQL+Server"
)
engine = create_engine(connection_string)
