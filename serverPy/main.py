import pyodbc
from flask import Flask, render_template, request, redirect, url_for
import random

app = Flask(__name__)


@app.route('/showAllClient', methods=['GET'])
def showAllClient():
    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        query = f""" SELECT * FROM Client """
        cursor.execute(query)
        response = '['
        for row in cursor.fetchall():
            response += "{"
            response += f'\"idClient\":\"{row[0]}\",' \
                        f'\"surname\":\"{row[1]}\",' \
                        f'\"name\":\"{row[2]}\",' \
                        f'\"lastname\":\"{row[3]}\",' \
                        f'\"phone\":\"{row[4]}\",' \
                        f'\"mail\":\"{row[5]}\"'
            response += "},"

        response = response[:-1]
        response += "]"
        return response


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


@app.route('/orderDay', methods=['GET'])
def orderDay():
    day = request.args.get('day')
    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        query = f""" SELECT * FROM MasrerOrder m
                    LEFT JOIN Master mas ON m.idMaster = mas.idMaster
                    RIGHT JOIN Orders o ON o.idOrder = m.idOrder
                    LEFT JOIN Model mod ON mod.idModel = o.idModel
                    LEFT JOIN Client c ON c.idClient = o.idClient
                    WHERE o.registrationDate = '{day}'  """
        cursor.execute(query)
        response = '['
        for row in cursor.fetchall():
            response += "{"

            response += f"\"idMaster\":\"{row[0]}\"," \
                        f"\"idOrder\":\"{row[1]}\"," \
                        f"\"idMaster\":\"{row[2]}\"," \
                        f"\"surnameMaster\":\"{row[3]}\"," \
                        f"\"nameMaster\":\"{row[4]}\"," \
                        f"\"lastnameMaster\":\"{row[5]}\"," \
                        f"\"salary\":\"{row[6]}\"," \
                        f"\"idOrder\":\"{row[7]}\"," \
                        f"\"registrationOrder\":\"{row[8]}\"," \
                        f"\"presumptiveDate\":\"{row[9]}\"," \
                        f"\"idModel\":\"{row[10]}\"," \
                        f"\"idClient\":\"{row[11]}\"," \
                        f"\"costOrder\":\"{row[12]}\"," \
                        f"\"prepayment\":\"{row[13]}\"," \
                        f"\"statusOrder\":\"{row[14]}\"," \
                        f"\"idModel\":\"{row[15]}\"," \
                        f"\"cost\":\"{row[16]}\"," \
                        f"\"weight\":\"{row[17]}\"," \
                        f"\"productionTime\":\"{row[18]}\"," \
                        f"\"nameCake\":\"{row[19]}\"," \
                        f"\"type\":\"{row[20]}\"," \
                        f"\"patch\":\"{row[21]}\"," \
                        f"\"idClient\":\"{row[22]}\"," \
                        f"\"surnameClient\":\"{row[23]}\"," \
                        f"\"nameClient\":\"{row[24]}\"," \
                        f"\"lastnameClient\":\"{row[25]}\"," \
                        f"\"phone\":\"{row[26]}\"," \
                        f"\"mail\":\"{row[27]}\""


            response += "},"
        response = response[:-1]
        response += "]"
        print(response)
        return response

@app.route('/populationCake', methods=['GET'])
def populationCake():
    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        query = f""" SELECT o.idModel, COUNT(o.idModel), m.name, m.type, m.patch
                     FROM Orders o 
                     LEFT JOIN Model m ON m.idModel = o.idModel GROUP BY o.idModel,  m.name, m.type, m.patch ;  """
        cursor.execute(query)
        response = '['
        for row in cursor.fetchall():
            response += "{"
            response += f'\"idModel\":\"{row[0]}\",' \
                        f'\"count\":\"{row[1]}\",' \
                        f'\"name\":\"{row[2]}\",' \
                        f'\"type\":\"{row[3]}\",' \
                        f'\"patch\":\"{row[4]}\"'

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
    print(idClient)
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
    id = request.args.get('idOrder')
    prepayment = request.args.get('prepayment')
    status = request.args.get('status')
    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()

        query = f""" INSERT INTO Orders VALUES('{id}', '{registrationDate}', '{presumptiveDate}', '{idModel}', '{idClient}', '{cost}', '{prepayment}', '{status}') """
        cursor.execute(query)

    return "Ok"


@app.route('/assignment', methods=['GET'])
def assignment():
    idMaster = request.args.get('idMaster')
    idOrder = request.args.get('idOrder')
    status = request.args.get('status')
    date = request.args.get('date')
    print(date)
    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        id = random.randint(0, 30000)
        query = f""" INSERT INTO MasrerOrder(idMaster, idOrder) VALUES ('{idMaster}', '{idOrder}') """
        cursor.execute(query)

        query = f""" update Orders set statusOrder='{status}', presumptiveDate = '{date}' where idOrder = '{idOrder}' """
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


@app.route('/getMasterOrders', methods=['GET'])
def getMasterOrders():
    with pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=test;Trusted_Connection=yes;') as db:
        cursor = db.cursor()
        id = random.randint(0, 30000)
        query = f""" SELECT * FROM MasrerOrder m
        LEFT JOIN Master mas ON m.idMaster = mas.idMaster
        LEFT JOIN Orders o ON o.idOrder = m.idOrder
        LEFT JOIN Model mod ON mod.idModel = o.idModel
		LEFT JOIN Client c ON c.idClient = o.idClient """
        cursor.execute(query)
        response = '['
        for row in cursor.fetchall():
            response += "{"
            response += f"\"idMaster\":\"{row[0]}\"," \
                        f"\"idOrder\":\"{row[1]}\"," \
                        f"\"idMaster\":\"{row[2]}\"," \
                        f"\"surnameMaster\":\"{row[3]}\"," \
                        f"\"nameMaster\":\"{row[4]}\"," \
                        f"\"lastnameMaster\":\"{row[5]}\"," \
                        f"\"salary\":\"{row[6]}\"," \
                        f"\"idOrder\":\"{row[7]}\"," \
                        f"\"registrationOrder\":\"{row[8]}\"," \
                        f"\"presumptiveDate\":\"{row[9]}\"," \
                        f"\"idModel\":\"{row[10]}\"," \
                        f"\"idClient\":\"{row[11]}\"," \
                        f"\"costOrder\":\"{row[12]}\"," \
                        f"\"prepayment\":\"{row[13]}\"," \
                        f"\"statusOrder\":\"{row[14]}\"," \
                        f"\"idModel\":\"{row[15]}\"," \
                        f"\"cost\":\"{row[16]}\"," \
                        f"\"weight\":\"{row[17]}\"," \
                        f"\"productionTime\":\"{row[18]}\"," \
                        f"\"nameCake\":\"{row[19]}\"," \
                        f"\"type\":\"{row[20]}\"," \
                        f"\"patch\":\"{row[21]}\"," \
                        f"\"idClient\":\"{row[22]}\"," \
                        f"\"surnameClient\":\"{row[23]}\"," \
                        f"\"nameClient\":\"{row[24]}\"," \
                        f"\"lastnameClient\":\"{row[25]}\"," \
                        f"\"phone\":\"{row[26]}\"," \
                        f"\"mail\":\"{row[27]}\""
            response += "},"
        response = response[:-1]
        response += "]"
        print(response)
        return response
    return "Ok"


if __name__ == "__main__":
    app.run(host='192.168.100.4', port=8008)
