package ru.eremin.kursovayarabota.datasources.repo

import com.soywiz.klock.DateTime
import ru.eremin.kursovayarabota.Client
import ru.eremin.kursovayarabota.Model
import ru.eremin.kursovayarabota.Orders
import ru.eremin.kursovayarabota.datasources.db.DAO
import ru.eremin.kursovayarabota.datasources.db.MasterEntity
import kotlin.random.Random


interface IRepository{
    suspend fun showCakeByCost(cost: Int)
    suspend fun showOrdersByDate(presumptiveDate: Int)
    suspend fun showOrdersByIndividualClient(idClient: Int)
    suspend fun assignmentMaster(idMaster: Int, idOrder: Int)
    suspend fun showOrdersByIndividualMaster(idMaster: Int)
    suspend fun createOrder(cakes: Model, idClient: Long)
    suspend fun createMaster(masterEntity: MasterEntity)
    suspend fun createCake()
    suspend fun showAllCake(typeCake: TypeCake): List<Model>

    suspend fun auth(phoneNumber: String, email: String): Client?

    suspend fun createClient(
                              surname: String,
                              name: String,
                              lastname: String,
                              phoneNumber: String,
                              mail: String)
}

enum class TypeCake{
    Fruits,
    Milk,
    Chocolate,
}

sealed class Status(val status: String){
    object Receive: Status("Принят")
    object Preparing: Status("Готовится")
    object Ready: Status("Готов")
}

class Repository(
   private val dao: DAO
): IRepository {

    private var idClient: Long? = null

    override suspend fun showAllCake(typeCake: TypeCake): List<Model> {
       return dao.showAllCake(typeCake)
    }

    override suspend fun auth(phoneNumber: String, email: String): Client? {
        val client = dao.auth(phoneNumber, email)
        idClient = client?.idClient
        return client
    }

    override suspend fun createClient(
        surname: String,
        name: String,
        lastname: String,
        phoneNumber: String,
        mail: String
    ) {
        idClient = Random.nextLong()
        dao.createClient(Client(idClient!!, surname, name, lastname, phoneNumber, mail))
    }

    override suspend fun createCake() {
        val cakes = listOf(
            Model(
                idModel = Random.nextLong(),
                cost = 3000,
                weight = 1200.0,
                productionTime = 2,
                name = "Экзотика",
                type = TypeCake.Fruits.name,
                patch = "https://i.ytimg.com/vi/9jO9dtHA14I/maxresdefault.jpg"
            ),
            Model(
                idModel = Random.nextLong(),
                cost = 4000,
                weight = 2200.0,
                productionTime = 2,
                name = "Ягодное наслаждение",
                type = TypeCake.Fruits.name,
                patch = "https://tortiki52.ru/wp-content/uploads/2016/05/20160513004444.jpg"
            ),
            Model(
                idModel = Random.nextLong(),
                cost = 8000,
                weight = 4200.0,
                productionTime = 3,
                name = "Свадебный ягодный торт",
                type = TypeCake.Fruits.name,
                patch = "https://kartinkin.net/uploads/posts/2021-07/thumbs/1627553428_60-kartinkin-com-p-tort-ukrashennii-fruktami-dlya-devochki-ye-63.jpg"
            ),
            Model(
                idModel = Random.nextLong(),
                cost = 2000,
                weight = 1200.0,
                productionTime = 1,
                name = "Торт с маскрапоне",
                type = TypeCake.Milk.name,
                patch = "https://static.1000.menu/img/content/24746/tort-molochnaya-devochka_1515476392_15_max.jpg"
            ),

            Model(
                idModel = Random.nextLong(),
                cost = 4400,
                weight = 2200.0,
                productionTime = 2,
                name = "Молочная девочка",
                type = TypeCake.Milk.name,
                patch = "https://sladkiy-dvor.ru/wp-content/uploads/2020/05/tort-molochnaya-devochka-recept-7.jpg"
            ),

            Model(
                idModel = Random.nextLong(),
                cost = 2400,
                weight = 1800.0,
                productionTime = 1,
                name = "Молочно-бисквитный торт",
                type = TypeCake.Milk.name,
                patch = "https://sweetmarin.ru/userfls/clauses/large/8024_tort-molochnaya-devochka.jpg"
            ),

            Model(
                idModel = Random.nextLong(),
                cost = 13000,
                weight = 9000.0,
                productionTime =3,
                name = "Шоколадный свадебный торт",
                type = TypeCake.Chocolate.name,
                patch = "https://www.firestock.ru/wp-content/uploads/2014/06/Fotolia_4622543_Subscription_L-700x927.jpg"
            ),
        )
        cakes.forEach {
            dao.createCake(it)
        }
    }

    override suspend fun showCakeByCost(cost: Int) {
        TODO("Not yet implemented")
    }

    override suspend fun showOrdersByDate(presumptiveDate: Int) {
        TODO("Not yet implemented")
    }

    override suspend fun showOrdersByIndividualClient(idClient: Int) {
        TODO("Not yet implemented")
    }

    override suspend fun assignmentMaster(idMaster: Int, idOrder: Int) {
        TODO("Not yet implemented")
    }

    override suspend fun showOrdersByIndividualMaster(idMaster: Int) {
        TODO("Not yet implemented")
    }

    override suspend fun createOrder(cakes: Model, idClient: Long) {
        cakes.apply {
            dao.createOrder(
                Orders(
                    idOrder = Random.nextLong(),
                    registrationDate = DateTime.now().unixMillisLong,
                    presumptiveDate = DateTime.now().unixMillisLong + productionTime,
                    idModel = idModel,
                    idClient = idClient,
                    costOrder = cost,
                    prepayment = null,
                    statusOrder = Status.Receive.status
                )

            )
        }
    }

    override suspend fun createMaster(masterEntity: MasterEntity) {
        TODO("Not yet implemented")
    }


}