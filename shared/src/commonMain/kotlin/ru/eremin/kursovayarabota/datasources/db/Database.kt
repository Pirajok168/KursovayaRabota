package ru.eremin.kursovayarabota.datasources.db

import com.squareup.sqldelight.db.SqlDriver
import ru.eremin.kursovayarabota.TableKursovaya


interface DAO{
    fun showCakeByCost(cost: Int)
    fun showOrdersByDate(presumptiveDate: Int)
    fun showOrdersByIndividualClient(idClient: Int)
    fun assignmentMaster(idMaster: Int, idOrder: Int)
    fun showOrdersByIndividualMaster(idMaster: Int)
    fun createOrder()
    fun createMaster(masterEntity: MasterEntity)
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

    override fun showCakeByCost(cost: Int) {
        dbQuery.showCakeByCost(cost.toLong())
    }

    override fun showOrdersByDate(presumptiveDate: Int) {
       dbQuery.showOrdesByDate(presumptiveDate.toLong())
    }

    override fun showOrdersByIndividualClient(idClient: Int) {
        dbQuery.showOrdersByIndividualClient(idClient.toLong())
    }

    override fun assignmentMaster(idMaster: Int, idOrder: Int) {
       dbQuery.assignmentMaster(idMaster.toLong(), idOrder.toLong())
    }

    override fun showOrdersByIndividualMaster(idMaster: Int) {
     dbQuery.showOrdersByIndividualMaster(idMaster.toLong())
    }

    override fun createOrder() {
        TODO()
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