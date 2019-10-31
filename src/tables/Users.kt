package com.lzyprime.tables

import org.jetbrains.exposed.dao.IntIdTable

object Users : IntIdTable() {
    val username = varchar("username", 20)
    val password = varchar("password", 20)
    val email = varchar("email", 30)
    val sex = integer("sex")
}

