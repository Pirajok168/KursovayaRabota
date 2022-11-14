package ru.eremin.kursovayarabota

import org.kodein.di.DI
import org.kodein.di.DirectDI
import org.kodein.di.direct
import ru.eremin.kursovayarabota.datasources.di.databaseModule
import kotlin.native.concurrent.ThreadLocal


@ThreadLocal
object KursovayaSDK {
    internal val di: DirectDI
        get() = requireNotNull(_di)
    private var _di: DirectDI? = null

    init {
        if (_di != null) {
            _di = null
        }

        val direct = DI {
            importAll(
                databaseModule
            )
        }.direct

        _di = direct
    }
}