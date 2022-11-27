package ru.eremin.kursovayarabota.datasources.repo

import com.soywiz.klock.DateTime
import ru.eremin.kursovayarabota.*
import ru.eremin.kursovayarabota.datasources.db.DAO
import ru.eremin.kursovayarabota.datasources.db.MasterEntity
import kotlin.random.Random


interface IRepository{
    suspend fun showCakeByCost(cost: Int): List<Model>

    suspend fun showOrdersByDate(presumptiveDate: Int)

    suspend fun showOrdersByIndividualClient(idClient: Long): List<ShowOrdersByIndividualClient>

    suspend fun assignmentMaster(idMaster: Int, idOrder: Long, idModel: Long)

    suspend fun showOrdersByIndividualMaster(idMaster: Int): List<Orders>

    suspend fun createOrder(id: Long, cakes: Model, idClient: Long)

    suspend fun createMaster()

    suspend fun createCake()

    suspend fun showAllCake(typeCake: TypeCake): List<Model>

    suspend fun auth(phoneNumber: String, email: String): Client?

    suspend fun createClient( id: Long,
                              surname: String,
                              name: String,
                              lastname: String,
                              phoneNumber: String,
                              mail: String)

    suspend fun showAllOrders(): List<AllOrders>

    suspend fun showAllMaster(): List<Master>

   suspend fun getMasterOrders(): List<GetMasterOrders>
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

    init {
        val a = 10
        a
    }

    override suspend fun showAllCake(typeCake: TypeCake): List<Model> {
       return dao.showAllCake(typeCake)
    }

    override suspend fun auth(phoneNumber: String, email: String): Client? {
        val client = dao.auth(phoneNumber, email)
        //idClient = client?.idClient
        return client
    }

    override suspend fun createClient(
        id: Long,
        surname: String,
        name: String,
        lastname: String,
        phoneNumber: String,
        mail: String
    ) {
        //idClient = Random.nextLong()
        dao.createClient(Client(id, surname, name, lastname, phoneNumber, mail))
    }

    override suspend fun showAllOrders(): List<AllOrders> = dao.showAllOrders()
    override suspend fun showAllMaster(): List<Master> = dao.showAllMaster()
    override suspend fun getMasterOrders(): List<GetMasterOrders>  = dao.getMasterOrders()

    override suspend fun createCake() {
        val cakes = listOf(
            Model(
                idModel = 1,
                cost = 3000,
                weight = 1200.0,
                productionTime = 2,
                name = "Экзотика",
                type = TypeCake.Fruits.name,
                patch = "https://i.ytimg.com/vi/9jO9dtHA14I/maxresdefault.jpg"
            ),
            Model(
                idModel = 2,
                cost = 4000,
                weight = 2200.0,
                productionTime = 2,
                name = "Ягодное наслаждение",
                type = TypeCake.Fruits.name,
                patch = "https://tortiki52.ru/wp-content/uploads/2016/05/20160513004444.jpg"
            ),
            Model(
                idModel = 3,
                cost = 8000,
                weight = 4200.0,
                productionTime = 3,
                name = "Свадебный ягодный торт",
                type = TypeCake.Fruits.name,
                patch = "https://kartinkin.net/uploads/posts/2021-07/thumbs/1627553428_60-kartinkin-com-p-tort-ukrashennii-fruktami-dlya-devochki-ye-63.jpg"
            ),
            Model(
                idModel = 4,
                cost = 2000,
                weight = 1200.0,
                productionTime = 1,
                name = "Торт с маскрапоне",
                type = TypeCake.Milk.name,
                patch = "https://static.1000.menu/img/content/24746/tort-molochnaya-devochka_1515476392_15_max.jpg"
            ),

            Model(
                idModel = 5,
                cost = 4400,
                weight = 2200.0,
                productionTime = 2,
                name = "Молочная девочка",
                type = TypeCake.Milk.name,
                patch = "https://sladkiy-dvor.ru/wp-content/uploads/2020/05/tort-molochnaya-devochka-recept-7.jpg"
            ),

            Model(
                idModel = 6,
                cost = 2400,
                weight = 1800.0,
                productionTime = 1,
                name = "Молочно-бисквитный торт",
                type = TypeCake.Milk.name,
                patch = "https://sweetmarin.ru/userfls/clauses/large/8024_tort-molochnaya-devochka.jpg"
            ),

            Model(
                idModel = 7,
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

    override suspend fun showCakeByCost(cost: Int): List<Model> {
        return dao.showCakeByCost(cost)
    }

    override suspend fun showOrdersByDate(presumptiveDate: Int) {
        TODO("Not yet implemented")
    }

    override suspend fun showOrdersByIndividualClient(idClient: Long): List<ShowOrdersByIndividualClient> {
        return dao.showOrdersByIndividualClient(idClient)
    }

    override suspend fun assignmentMaster(idMaster: Int, idOrder: Long, idModel: Long) {
        val model = dao.getOrderById(idOrder)
        dao.replaceOrder(model.copy(statusOrder = Status.Preparing.status))
        dao.assignmentMaster(idMaster, idOrder)
    }

    override suspend fun showOrdersByIndividualMaster(idMaster: Int): List<Orders> {
        TODO("Not yet implemented")
    }

    override suspend fun createOrder(id: Long, cakes: Model, idClient: Long) {

        dao.createOrder(
            Orders(
                idOrder = Random.nextLong(),
                registrationDate = DateTime.now().unixMillisLong,
                presumptiveDate = DateTime.now().unixMillisLong + cakes.productionTime,
                idModel = cakes.idModel,
                idClient = id,
                costOrder = cakes.cost,
                prepayment = null,
                statusOrder = Status.Receive.status
            )

        )

    }

    override suspend fun createMaster() {

        val list = listOf<MasterEntity>(
            MasterEntity(
                idMaster = 1,
                surname = "Михалков",
                lastname = "Владимирович",
                salary = 24000.0,
                name = "Игорь"
            ),

            MasterEntity(
                idMaster = 2,
                surname = "Жилин",
                lastname = "Игорьивич",
                salary = 24000.0,
                name = "Алексей"
            ),

            MasterEntity(
                idMaster = 3,
                surname = "Заиграев",
                lastname = "Владимирович",
                salary = 24000.0,
                name = "Алексей"
            ),

            MasterEntity(
                idMaster = 4,
                surname = "Кузнецов",
                lastname = "Владимирович",
                salary = 24000.0,
                name = "Артем"
            ),

            MasterEntity(
                idMaster = 5,
                surname = "Бондарь",
                lastname = "Владимирович",
                salary = 24000.0,
                name = "Максим"
            ),

            MasterEntity(
                idMaster = 6,
                surname = "Николавев",
                lastname = "Владимирович",
                salary = 24000.0,
                name = "Игорь"
            ),

            MasterEntity(
                idMaster = 7,
                surname = "Еремин",
                lastname = "Владимирович",
                salary = 1000000.0,
                name = "Данил"
            ),

            MasterEntity(
                idMaster = 8,
                surname = "Сазанов",
                lastname = "Владимирович",
                salary = 24000.0,
                name = "Алексей"
            ),

            MasterEntity(
                idMaster = 9,
                surname = "Михалков",
                lastname = "Владимирович",
                salary = 24000.0,
                name = "Игорь"
            ),
        )

        list.forEach {
            dao.createMaster(it)
        }
    }


}