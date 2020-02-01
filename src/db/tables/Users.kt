package com.lzyprime.db.tables

import org.jetbrains.exposed.dao.EntityID
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.dao.IntIdTable

object Users : IntIdTable() {
    val username = varchar("username", 20)
    val password = varchar("password", 20)
    val email = varchar("email", 30)
    val sex = integer("sex")
}

class User(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<User>(Users)

    var username by Users.username
    var password by Users.password
    var email by Users.email
    var sex by Users.sex
}