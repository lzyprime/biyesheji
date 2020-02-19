package com.lzyprime.db

import com.lzyprime.db.tables.FavoritePosts
import com.lzyprime.db.tables.Posts
import com.lzyprime.db.tables.Users
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SchemaUtils
import org.jetbrains.exposed.sql.transactions.transaction

object DB {
    private val db by lazy {
        Database.connect(
            "jdbc:sqlite:src/db/ktor_server.sqlite",
            "org.sqlite.JDBC"
        )
    }

    operator fun invoke() = db

    @JvmStatic
    fun main(args: Array<String>) {
        transaction(invoke()) {
            SchemaUtils.createMissingTablesAndColumns(Users, Posts, FavoritePosts)
        }
    }
}