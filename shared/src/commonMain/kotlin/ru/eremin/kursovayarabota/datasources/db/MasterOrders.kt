package ru.eremin.kursovayarabota.datasources.db

import kotlinx.serialization.Serializable


@Serializable
data class MasterOrders(
    val cost: String,
    val costOrder: String,
    val idClient: String,
    val idMaster: String,
    val idModel: String,
    val idOrder: String,
    val lastname: String,
    val name: String,
    val patch: String,
    val prepayment: String,
    val presumptiveDate: String,
    val productionTime: String,
    val name_: String,
    val registrationOrder: String,
    val salary: String,
    val statusOrder: String,
    val surname: String,
    val type: String,
    val weight: String
)