package ru.eremin.kursovayarabota.datasources.db

import com.squareup.sqldelight.db.SqlDriver
import ru.eremin.kursovayarabota.*
import ru.eremin.kursovayarabota.datasources.repo.TypeCake


interface DAO{
    fun showCakeByCost(cost: Int): List<Model>
    fun showOrdersByDate(presumptiveDate: Int)
    fun showOrdersByIndividualClient(idClient: Long): List<ShowOrdersByIndividualClient>
    fun assignmentMaster(idMaster: Int, idOrder: Long)
    fun showOrdersByIndividualMaster(idMaster: Int)
    fun createOrder(orders: Orders)
    fun createMaster(masterEntity: MasterEntity)
    fun createCake(cake: Model)
    fun showAllCake(typeCake: TypeCake): List<Model>


    suspend fun auth(phoneNumber: String, email: String): Client?

    fun createClient(client: Client)

    fun showAllOrders(): List<AllOrders>

    fun showAllMaster(): List<Master>

    fun getMasterOrders(): List<GetMasterOrders>

    fun getModelById(id: Long): Model

    fun replaceCake(cake: Model)

    fun getOrderById(idOrder: Long): Orders

    fun replaceOrder(orders: Orders)
}

interface IDatabase {
    val sqlDriver: SqlDriver
}

expect fun databaseFactory(): IDatabase

data class MasterEntity(
    val idMaster: Int,
    val surname: String,
    val lastname: String,
    val salary: Double,
    val name: String
)

class Database(
    driver: SqlDriver
): DAO {
    private val database = TableKursovaya(driver)
    private val dbQuery = database.tableKursovayaQueries
    override fun showAllCake(typeCake: TypeCake): List<Model> {
        return dbQuery.showAllCake().executeAsList()
    }

    override suspend fun auth(phoneNumber: String, email: String): Client? {
        return dbQuery.auth(phoneNumber, email).executeAsOneOrNull()
    }

    override fun createClient(client: Client) {
        client.apply {
            dbQuery.createClient(idClient, surname, name, lastname, phoneNumber, mail)
        }
    }

    override fun showAllOrders(): List<AllOrders> = dbQuery.allOrders().executeAsList()
    override fun showAllMaster(): List<Master> = dbQuery.showAllMaster().executeAsList()
    override fun getMasterOrders(): List<GetMasterOrders> = dbQuery.getMasterOrders().executeAsList()
    override fun getModelById(id: Long): Model = dbQuery.getCakesById(id).executeAsOne()
    override fun replaceCake(cake: Model) {
        cake.apply {
            dbQuery.replaceCake(idModel, cost, weight, productionTime, name, type, patch)
        }
    }

    override fun getOrderById(idOrder: Long): Orders = dbQuery.getOrderById(idOrder).executeAsOne()
    override fun replaceOrder(orders: Orders) {
        orders.apply {
            dbQuery.createOrder(idOrder, registrationDate, presumptiveDate, idModel, idClient, costOrder, prepayment, statusOrder)
        }
    }


    override fun createCake(cake: Model) {
        cake.apply {
            dbQuery.createCake(idModel, cost, weight, productionTime, name, type, patch)
        }
    }

    override fun showCakeByCost(cost: Int): List<Model> {
        return dbQuery.showCakeByCost(cost.toLong()).executeAsList()
    }

    override fun showOrdersByDate(presumptiveDate: Int) {
       dbQuery.showOrdesByDate(presumptiveDate.toLong())
    }

    override fun showOrdersByIndividualClient(idClient: Long): List<ShowOrdersByIndividualClient> {
        return dbQuery.showOrdersByIndividualClient(idClient).executeAsList()
    }

    override fun assignmentMaster(idMaster: Int, idOrder: Long) {
       dbQuery.assignmentMaster(idMaster.toLong(), idOrder.toLong())
    }

    override fun showOrdersByIndividualMaster(idMaster: Int) {
     dbQuery.showOrdersByIndividualMaster(idMaster.toLong())
    }

    override fun createOrder(orders: Orders) {
        orders.apply {
            dbQuery.createOrder(idOrder,
                registrationDate,
                presumptiveDate,
                idModel,
                idClient,
                costOrder,
                prepayment,
                statusOrder
            )
        }
    }

    override fun createMaster(masterEntity: MasterEntity) {
        dbQuery.createMaster(
            idMaster = masterEntity.idMaster.toLong(),
            surname =  masterEntity.surname,
            name = masterEntity.name,
            lastname = masterEntity.lastname,
            salary = masterEntity.salary
        )
    }




}