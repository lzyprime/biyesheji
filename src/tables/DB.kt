package com.lzyprime.tables

import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SchemaUtils
import org.jetbrains.exposed.sql.transactions.transaction

object DB {
    private val db by lazy {
        Database.connect(
            "jdbc:sqlite:/home/prime/Codes/biyesheji/server/src/tables/ktor_server.sqlite",
            "org.sqlite.JDBC"
        )
    }

    operator fun invoke() = db

    @JvmStatic
    fun main(args: Array<String>) {
        transaction(invoke()) {
            SchemaUtils.create(Users)
        }
    }
}