package ru.eremin.kursovayarabota.datasources.db

import kotlinx.serialization.Serializable


@Serializable
data class Cakes(
    val cost: String,
    val idModel: String,
    val name: String,
    val productionTime: String,
    val type: String,
    val weight: String,
    val patch: String
)