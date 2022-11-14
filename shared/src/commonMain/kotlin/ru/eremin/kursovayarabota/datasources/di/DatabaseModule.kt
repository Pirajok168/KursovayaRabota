package ru.eremin.kursovayarabota.datasources.di

import org.kodein.di.DI
import org.kodein.di.bind
import org.kodein.di.instance
import org.kodein.di.singleton
import ru.eremin.kursovayarabota.KursovayaSDK
import ru.eremin.kursovayarabota.datasources.db.DAO
import ru.eremin.kursovayarabota.datasources.db.Database
import ru.eremin.kursovayarabota.datasources.db.databaseFactory
import kotlin.native.concurrent.ThreadLocal


internal val databaseModule = DI.Module("DatabaseModule") {
    bind<DAO>() with singleton {
        Database(
            driver = databaseFactory().sqlDriver
        )
    }

}

@ThreadLocal
object DatabaseModule {
    val repo: DAO
        get() = KursovayaSDK.di.instance()


}

val KursovayaSDK.dialogChatModule: DatabaseModule
    get() = DatabaseModule