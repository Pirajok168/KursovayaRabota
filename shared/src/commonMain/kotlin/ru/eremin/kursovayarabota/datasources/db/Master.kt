package ru.eremin.kursovayarabota.datasources.db

import kotlinx.serialization.Serializable


@Serializable
data class Master(
    val idMaster: String,
    val lastname: String,
    val name: String,
    val salary: String,
    val surname: String
)