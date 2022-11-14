package ru.eremin.kursovayarabota

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform