package ru.eremin.kursovayarabota.datasources.di

import org.kodein.di.DI
import org.kodein.di.bind
import org.kodein.di.instance
import org.kodein.di.singleton
import ru.eremin.kursovayarabota.KursovayaSDK
import ru.eremin.kursovayarabota.datasources.api.ApiClient
import ru.eremin.kursovayarabota.datasources.api.IApi
import ru.eremin.kursovayarabota.datasources.api.getHttpEngineFactory
import kotlin.native.concurrent.ThreadLocal


internal val databaseModule = DI.Module("DatabaseModule") {


    bind<IApi>() with singleton {
        ApiClient(
            getHttpEngineFactory().engine
        )
    }

}

@ThreadLocal
object DatabaseModule {


    val update: IApi
        get() = KursovayaSDK.di.instance()
}

val KursovayaSDK.dialogChatModule: DatabaseModule
    get() = DatabaseModule