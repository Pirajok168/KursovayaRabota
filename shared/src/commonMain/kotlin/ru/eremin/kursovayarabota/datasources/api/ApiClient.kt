package ru.eremin.kursovayarabota.datasources.api

import com.soywiz.klock.DateFormat
import com.soywiz.klock.DateTime
import com.soywiz.klock.days
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

    suspend fun createOrder(idModel: String, idClient: String, cost: String, time: Int)

    suspend fun getMasterOrders(): List<MasterOrders>
}

const val BASE = "http://192.168.100.4:8008"

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
        return  try {
            Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            }.decodeFromString(text)
        }catch (e :SerializationException){
            emptyList<Cakes>()
        }
    }

    override suspend fun showCakeByCost(cost: String): List<Cakes> {
        val text = httpClient.get("${BASE}/showCakeByCost") {
            url {
                parameter("cost", cost.toString())
            }
        }.bodyAsText()
        return try {
            Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            }.decodeFromString(text)
        } catch (e :SerializationException){
            emptyList<Cakes>()
        }
    }

    override suspend fun showOrderByIndividualClient(idClient: String): List<OrderForClient> {
        val text = httpClient.get("${BASE}/showOrderByIndividualClient") {
            url {
                parameter("idClient", idClient.toString())
            }
        }.bodyAsText()
        return try {
            Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            }.decodeFromString(text)
        } catch (e :SerializationException){
            emptyList<OrderForClient>()
        }
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
        return try {
            Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            }.decodeFromString(text)
        } catch (e :SerializationException){
            emptyList<Orders>()
        }
    }

    override suspend fun showMaster(): List<Master> {
        val text = httpClient.get("${BASE}/showMaster") {

        }.bodyAsText()
        return try {
            Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            }.decodeFromString(text)
        } catch (e :SerializationException){
            emptyList<Master>()
        }
    }

    override suspend fun createOrder(idModel: String, idClient: String, cost: String, time: Int) {
        val dateFormat = DateFormat("EEE, dd MM yyyy HH:mm")
        val registrationDate = DateTime.now().format(dateFormat)
        val presumptiveDate = DateTime.now().plus(time.days).format(dateFormat)
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
        return try {
            Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            }.decodeFromString(text)
        } catch (e :SerializationException){
            emptyList<MasterOrders>()
        }
    }

}