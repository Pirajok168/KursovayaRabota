import pyodbc
from flask import Flask, render_template, request, redirect, url_for
import random

app = Flask(__name__)


@app.route('/auth', methods=['GET'])
def auth():
    number = request.args.get('number')
    email = request.args.get('email')

    print(number)
    print(email)

    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        query = f""" SELECT * FROM Client WHERE phoneNumber = '{number}'AND mail = '{email}' """
        cursor.execute(query)
        response = '{'
        for row in cursor.fetchall():
            print('вы успешно вошли')
            response += f'\"idClient\":\"{row[0]}\",' \
                        f'\"surname\":\"{row[1]}\",' \
                        f'\"name\":\"{row[2]}\",' \
                        f'\"lastname\":\"{row[3]}\",' \
                        f'\"phone\":\"{row[4]}\",' \
                        f'\"mail\":\"{row[5]}\"'
            response += '}'
            return response
        print('вы не вошли')
        return 'вы не вошли'


@app.route('/getCake', methods=['GET'])
def getCake():
    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        query = f""" SELECT * FROM Model """
        cursor.execute(query)
        response = '['
        for row in cursor.fetchall():
            response += "{"
            response += f'\"idModel\":\"{row[0]}\",' \
                        f'\"cost\":\"{row[1]}\",' \
                        f'\"weight\":\"{row[2]}\",' \
                        f'\"productionTime\":\"{row[3]}\",' \
                        f'\"name\":\"{row[4]}\",' \
                        f'\"type\":\"{row[5]}\",' \
                        f'\"patch\":\"{row[6]}\"'

            response += "},"
        response = response[:-1]
        response += "]"
        print(response)
        return response


@app.route('/showCakeByCost', methods=['GET'])
def showCakeByCost():
    cost = request.args.get('cost')
    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        query = f""" SELECT * FROM Model WHERE cost BETWEEN 0 AND {cost} """
        cursor.execute(query)
        response = '['
        for row in cursor.fetchall():
            response += "{"
            response += f'\"idModel\":\"{row[0]}\",' \
                        f'\"cost\":\"{row[1]}\",' \
                        f'\"weight\":\"{row[2]}\",' \
                        f'\"productionTime\":\"{row[3]}\",' \
                        f'\"name\":\"{row[4]}\",' \
                        f'\"type\":\"{row[5]}\",' \
                        f'\"patch\":\"{row[6]}\"'

            response += "},"
        response = response[:-1]
        response += "]"
        print(response)
        return response


@app.route('/showOrderByIndividualClient', methods=['GET'])
def showOrderByIndividualClient():
    idClient = request.args.get('idClient')
    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        query = f""" SELECT * FROM Orders o LEFT JOIN Model m ON m.idModel = o.idModel WHERE o.idClient = {idClient} """
        cursor.execute(query)
        response = '['
        for row in cursor.fetchall():
            response += "{"
            response += f"\"idOrder\":\"{row[0]}\"," \
                        f"\"registrationDate\":\"{row[1]}\"," \
                        f"\"presumptiveDate\":\"{row[2]}\"," \
                        f"\"idModel\":\"{row[3]}\"," \
                        f"\"idClient\":\"{row[4]}\"," \
                        f"\"costOrder\":\"{row[5]}\"," \
                        f"\"prepayment\":\"{row[6]}\"," \
                        f"\"statusOrder\":\"{row[7]}\"," \
                        f"\"idModel_\":\"{row[8]}\"," \
                        f"\"cost\":\"{row[9]}\"," \
                        f"\"weight\":\"{row[10]}\"," \
                        f"\"productionTime\":\"{row[11]}\"," \
                        f"\"name\":\"{row[12]}\"," \
                        f"\"type\":\"{row[13]}\"," \
                        f"\"patch\":\"{row[14]}\""

            response += "},"
        response = response[:-1]
        response += "]"
        print(response)
        return response


@app.route('/createOrder', methods=['GET'])
def createOrder():
    idModel = request.args.get('idModel')
    idClient = request.args.get('idClient')
    cost = request.args.get('cost')
    registrationDate = request.args.get('registrationDate')
    presumptiveDate = request.args.get('presumptiveDate')
    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        id = random.randint(0, 30000)
        query = f""" INSERT INTO Orders VALUES('{id}', '{registrationDate}', '{presumptiveDate}', '{idModel}', '{idClient}', '{cost}', '{0}', \'Принят\') """
        cursor.execute(query)

    return "Ok"


@app.route('/assignment', methods=['GET'])
def assignment():
    idMaster = request.args.get('idMaster')
    idOrder = request.args.get('idOrder')

    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        id = random.randint(0, 30000)
        query = f""" INSERT INTO MasrerOrder(idMaster, idOrder) VALUES ('{idMaster}', '{idOrder}') """
        cursor.execute(query)

    return "Ok"


@app.route('/showOrder', methods=['GET'])
def showOrder():
    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        id = random.randint(0, 30000)
        query = f""" SELECT * FROM Orders o LEFT JOIN Model m ON o.idModel = m.idModel LEFT JOIN Client c ON o.idClient = c.idClient """
        cursor.execute(query)
        response = '['
        for row in cursor.fetchall():
            response += "{"
            response += f"\"idOrder\":\"{row[0]}\"," \
                        f"\"registrationDate\":\"{row[1]}\"," \
                        f"\"presumptiveDate\":\"{row[2]}\"," \
                        f"\"idModel\":\"{row[3]}\"," \
                        f"\"idClient\":\"{row[4]}\"," \
                        f"\"costOrder\":\"{row[5]}\"," \
                        f"\"prepayment\":\"{row[6]}\"," \
                        f"\"statusOrder\":\"{row[7]}\"," \
                        f"\"idModel_\":\"{row[8]}\"," \
                        f"\"cost\":\"{row[9]}\"," \
                        f"\"weight\":\"{row[10]}\"," \
                        f"\"productionTime\":\"{row[11]}\"," \
                        f"\"name\":\"{row[12]}\"," \
                        f"\"type\":\"{row[13]}\"," \
                        f"\"patch\":\"{row[14]}\"," \
                        f"\"idClient_\":\"{row[15]}\"," \
                        f"\"surname\":\"{row[16]}\"," \
                        f"\"name_\":\"{row[17]}\"," \
                        f"\"lastname\":\"{row[18]}\"," \
                        f"\"phoneNumber\":\"{row[19]}\"," \
                        f"\"mail\":\"{row[20]}\""

            response += "},"
        response = response[:-1]
        response += "]"
        print(response)
        return response
    return "Ok"


@app.route('/showMaster', methods=['GET'])
def showMaster():
    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        id = random.randint(0, 30000)
        query = f""" SELECT * FROM Master """
        cursor.execute(query)
        response = '['
        for row in cursor.fetchall():
            response += "{"
            response += f"\"idMaster\":\"{row[0]}\"," \
                        f"\"surname\":\"{row[1]}\"," \
                        f"\"name\":\"{row[2]}\"," \
                        f"\"lastname\":\"{row[3]}\"," \
                        f"\"salary\":\"{row[4]}\""

            response += "},"
        response = response[:-1]
        response += "]"
        print(response)
        return response
    return "Ok"


if __name__ == "__main__":
    app.run(host='192.168.100.4', port=8000)
