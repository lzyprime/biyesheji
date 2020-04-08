package com.lzyprime.db

import com.lzyprime.db.tables.*
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SchemaUtils
import org.jetbrains.exposed.sql.transactions.TransactionManager
import org.jetbrains.exposed.sql.transactions.transaction

object DB {
    private val db by lazy {
        Database.connect(
            "jdbc:mariadb://127.0.0.1:3306/biyesheji",
            "org.mariadb.jdbc.Driver",
            "root",
            "3821"
        )
    }

    operator fun invoke() = db

    @JvmStatic
    fun main(args: Array<String>) {
        transaction(invoke()) {
            SchemaUtils.createMissingTablesAndColumns(Users, Posts, FavoritePosts, Attentions, Comments)
        }
    }
}