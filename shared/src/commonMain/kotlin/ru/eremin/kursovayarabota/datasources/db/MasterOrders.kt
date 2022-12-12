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
    val lastnameClient: String,
    val lastnameMaster: String,
    val mail: String,
    val nameCake: String,
    val nameClient: String,
    val nameMaster: String,
    val patch: String,
    val phone: String,
    val prepayment: String,
    val presumptiveDate: String,
    val productionTime: String,
    val registrationOrder: String,
    val salary: String,
    val statusOrder: String,
    val surnameClient: String,
    val surnameMaster: String,
    val type: String,
    val weight: String
)