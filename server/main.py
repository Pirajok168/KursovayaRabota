import mysql.connector


connection = mysql.connector.connect(host='192.168.100.4', database='test', user='user1', password='User2')
connection.cursor()