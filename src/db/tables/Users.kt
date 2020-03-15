package com.lzyprime.db.tables

import org.jetbrains.exposed.dao.IntIdTable

object Users : IntIdTable() {
    val username = varchar("username", 20)
    val password = varchar("password", 20)
    val email = varchar("email", 30)
    val sex = integer("sex").default(0)
    val avatar = varchar("avatar", 100).default("data:image/jpeg;base64,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")
}
