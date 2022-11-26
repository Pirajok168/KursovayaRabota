package ru.eremin.kursovayarabota.datasources.db

import co.touchlab.sqliter.DatabaseConfiguration
import com.squareup.sqldelight.db.SqlDriver
import com.squareup.sqldelight.drivers.native.NativeSqliteDriver
import com.squareup.sqldelight.drivers.native.wrapConnection
import ru.eremin.kursovayarabota.TableKursovaya

class InitDatabase: IDatabase {

    val dbConfig = DatabaseConfiguration(
        name = "tableKursovaya.db",
        version = 1,
        create = { connection ->
            wrapConnection(connection) { TableKursovaya.Schema.create(it) }
        },
        extendedConfig = DatabaseConfiguration.Extended(foreignKeyConstraints = true)
    )

    override val sqlDriver: SqlDriver
        get() = NativeSqliteDriver(dbConfig)
}

actual fun databaseFactory(): IDatabase = InitDatabase()