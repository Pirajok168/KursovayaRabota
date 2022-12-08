package ru.eremin.kursovayarabota.datasources.api

import io.ktor.client.engine.*
import io.ktor.client.engine.darwin.*


class HttpFactory(override val engine: HttpClientEngineFactory<HttpClientEngineConfig> = Darwin) : HttpEngineFactory {

}


actual fun getHttpEngineFactory(): HttpEngineFactory = HttpFactory()