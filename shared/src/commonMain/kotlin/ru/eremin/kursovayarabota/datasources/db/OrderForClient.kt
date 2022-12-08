package ru.eremin.kursovayarabota.datasources.db

import kotlinx.serialization.Serializable


@Serializable
data class OrderForClient(
    val cost: String,
    val costOrder: String,
    val idClient: String,
    val idModel: String,
    val idModel_: String,
    val idOrder: String,
    val name: String,
    val patch: String,
    val prepayment: String,
    val presumptiveDate: String,
    val productionTime: String,
    val registrationDate: String,
    val statusOrder: String,
    val type: String,
    val weight: String
)