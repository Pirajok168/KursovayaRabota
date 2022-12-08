package ru.eremin.kursovayarabota.datasources.db

import kotlinx.serialization.Serializable


@Serializable
data class Orders(
    val cost: String,
    val costOrder: String,
    val idClient: String,
    val idClient_: String,
    val idModel: String,
    val idModel_: String,
    val idOrder: String,
    val lastname: String,
    val mail: String,
    val name: String,
    val name_: String,
    val patch: String,
    val phoneNumber: String,
    val prepayment: String,
    val presumptiveDate: String,
    val productionTime: String,
    val registrationDate: String,
    val statusOrder: String,
    val surname: String,
    val type: String,
    val weight: String
)