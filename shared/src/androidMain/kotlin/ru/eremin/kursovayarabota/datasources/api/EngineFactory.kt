package ru.eremin.kursovayarabota.datasources.api

import io.ktor.client.engine.*
import io.ktor.client.engine.okhttp.*

class EngineFactory(override val engine: HttpClientEngineFactory<HttpClientEngineConfig> = OkHttp) : HttpEngineFactory

actual fun getHttpEngineFactory(): HttpEngineFactory = EngineFactory()