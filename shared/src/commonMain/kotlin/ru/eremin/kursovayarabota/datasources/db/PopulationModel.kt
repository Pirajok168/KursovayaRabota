package ru.eremin.kursovayarabota.datasources.db

import kotlinx.serialization.Serializable

@Serializable
data class PopulationModel(
    val count: String,
    val idModel: String,
    val name: String,
    val patch: String,
    val type: String
)