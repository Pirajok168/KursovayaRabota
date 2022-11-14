package ru.eremin.kursovayarabota.datasources.db

import android.annotation.SuppressLint
import android.content.Context
import androidx.sqlite.db.SupportSQLiteDatabase
import androidx.startup.Initializer
import com.squareup.sqldelight.android.AndroidSqliteDriver
import com.squareup.sqldelight.db.SqlDriver
import ru.eremin.kursovayarabota.TableKursovaya


class ContextApplication private constructor(val context: Context){


    companion object{
        @SuppressLint("StaticFieldLeak")
        private var instance: ContextApplication? = null

        fun init(context: Context): ContextApplication{
            return if (instance == null){
                instance = ContextApplication(context)
                instance!!
            }else{
                instance!!
            }
        }

        fun getContextApplication(): ContextApplication{
            return instance!!
        }
    }
}

class MyAppContextInitialise: Initializer<ContextApplication> {
    override fun create(context: Context): ContextApplication {
        return ContextApplication.init(context)
    }

    override fun dependencies(): List<Class<out Initializer<*>>> {
        return emptyList()
    }

}


class InitDatabase(
    context: Context = ContextApplication.getContextApplication().context,
    override val sqlDriver: SqlDriver =  AndroidSqliteDriver(
        TableKursovaya.Schema,
        context,
        "tableKursovaya.db",
        callback = object : AndroidSqliteDriver.Callback(TableKursovaya.Schema) {
            override fun onConfigure(db: SupportSQLiteDatabase) {
                super.onConfigure(db)
                db.setForeignKeyConstraintsEnabled(true)
            }
        })
):IDatabase

actual fun databaseFactory(): IDatabase = InitDatabase()
