package ru.eremin.kursovayarabota.datasources.db

import kotlinx.serialization.Serializable

@Serializable
data class Client(
    val idClient: String,
    val lastname: String,
    val mail: String,
    val name: String,
    val phone: String,
    val surname: String
)