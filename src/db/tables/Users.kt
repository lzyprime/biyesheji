package com.lzyprime.db.tables

import org.jetbrains.exposed.dao.IntIdTable

object Users : IntIdTable() {
    val username = varchar("username", 20)
    val password = varchar("password", 20)
    val email = varchar("email", 30)
    val sex = integer("sex").default(0)
    val avatar = varchar("avatar", 100)
    val authCode = varchar("authCode", 100).default("")
}
