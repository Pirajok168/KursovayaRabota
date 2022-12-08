package ru.eremin.kursovayarabota.datasources.api

import com.soywiz.klock.Date
import com.soywiz.klock.DateTime
import io.ktor.client.*
import io.ktor.client.engine.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.serialization.kotlinx.json.*
import kotlinx.serialization.SerializationException
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import ru.eremin.kursovayarabota.datasources.db.*


interface HttpEngineFactory {
    val engine: HttpClientEngineFactory<HttpClientEngineConfig>
}

expect fun getHttpEngineFactory(): HttpEngineFactory

interface IApi{
    suspend fun auth(number: String, email: String): Client?
    suspend fun getCake(): List<Cakes>

    suspend fun showCakeByCost(cost: String): List<Cakes>

    suspend fun showOrderByIndividualClient(idClient: String): List<OrderForClient>

    suspend fun assignmentMaster(idMaster: String, idOrder: String)

    suspend fun showOrder(): List<Orders>

    suspend fun showMaster(): List<Master>

    suspend fun createOrder(idModel: String, idClient: String, cost: String)

    suspend fun getMasterOrders(): List<MasterOrders>
}

const val BASE = "http://192.168.100.4:8000"

class ApiClient(
    engine: HttpClientEngineFactory<HttpClientEngineConfig>
): IApi {
    private val httpClient = HttpClient(engine) {
        install(ContentNegotiation) {
            json(Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            })
        }
    }

    override suspend fun auth(number: String, email: String): Client? {
        return try {
            val body = httpClient.get("$BASE/auth") {
                url{
                    parameter("number", number)
                    parameter("email", email)
                }
            }.bodyAsText()

             Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            }.decodeFromString(body)
        }catch (e :SerializationException){
            null
        }


    }

    override suspend fun getCake(): List<Cakes> {
        val text = httpClient.get("${BASE}/getCake").bodyAsText()
        return Json {
            prettyPrint = true
            isLenient = true
            ignoreUnknownKeys = true
        }.decodeFromString(text)
    }

    override suspend fun showCakeByCost(cost: String): List<Cakes> {
        val text = httpClient.get("${BASE}/showCakeByCost") {
            url {
                parameter("cost", cost.toString())
            }
        }.bodyAsText()
        return Json {
            prettyPrint = true
            isLenient = true
            ignoreUnknownKeys = true
        }.decodeFromString(text)
    }

    override suspend fun showOrderByIndividualClient(idClient: String): List<OrderForClient> {
        val text = httpClient.get("${BASE}/showOrderByIndividualClient") {
            url {
                parameter("idClient", idClient.toString())
            }
        }.bodyAsText()
        return Json {
            prettyPrint = true
            isLenient = true
            ignoreUnknownKeys = true
        }.decodeFromString(text)
    }

    override suspend fun assignmentMaster(idMaster: String, idOrder: String) {
        httpClient.get("${BASE}/assignment"){
            url {
                parameter("idMaster", idMaster.toString())
                parameter("idOrder", idOrder.toString())
            }
        }
    }

    override suspend fun showOrder(): List<Orders> {
        val text = httpClient.get("${BASE}/showOrder") {

        }.bodyAsText()
        return Json {
            prettyPrint = true
            isLenient = true
            ignoreUnknownKeys = true
        }.decodeFromString(text)
    }

    override suspend fun showMaster(): List<Master> {
        val text = httpClient.get("${BASE}/showMaster") {

        }.bodyAsText()
        return Json {
            prettyPrint = true
            isLenient = true
            ignoreUnknownKeys = true
        }.decodeFromString(text)
    }

    override suspend fun createOrder(idModel: String, idClient: String, cost: String) {
        val registrationDate = DateTime.now().unixMillisLong.toString()
        val presumptiveDate = DateTime.now().unixMillisLong.toString()
        httpClient.get("${BASE}/createOrder"){
            url {
                parameter("idModel", idModel)
                parameter("idClient", idClient)
                parameter("cost", cost)
                parameter("registrationDate", registrationDate)
                parameter("presumptiveDate", presumptiveDate)
            }
        }
    }
    override suspend fun getMasterOrders(): List<MasterOrders> {
        val text = httpClient.get("${BASE}/getMasterOrders") {
            url {

            }
        }.bodyAsText()
        return Json {
            prettyPrint = true
            isLenient = true
            ignoreUnknownKeys = true
        }.decodeFromString(text)
    }

}