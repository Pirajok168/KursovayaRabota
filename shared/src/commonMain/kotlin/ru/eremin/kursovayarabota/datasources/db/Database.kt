package ru.eremin.kursovayarabota.datasources.db

import com.squareup.sqldelight.db.SqlDriver
import ru.eremin.kursovayarabota.Model
import ru.eremin.kursovayarabota.TableKursovaya
import ru.eremin.kursovayarabota.datasources.repo.TypeCake


interface DAO{
    fun showCakeByCost(cost: Int): Model?
    fun showOrdersByDate(presumptiveDate: Int)
    fun showOrdersByIndividualClient(idClient: Int)
    fun assignmentMaster(idMaster: Int, idOrder: Int)
    fun showOrdersByIndividualMaster(idMaster: Int)
    fun createOrder()
    fun createMaster(masterEntity: MasterEntity)
    fun createCake(cake: Model)
    fun showAllCake(typeCake: TypeCake): List<Model>
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
        return dbQuery.showAllCake(typeCake.name).executeAsList()
    }

    override fun createCake(cake: Model) {
        cake.apply {
            dbQuery.createCake(idModel, cost, weight, productionTime, name, type, patch)
        }
    }

    override fun showCakeByCost(cost: Int): Model?{
        return dbQuery.showCakeByCost(cost.toLong()).executeAsOneOrNull()
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