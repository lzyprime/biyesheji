package com.lzyprime.db.tables

import org.jetbrains.exposed.sql.Table


object FavoritePosts: Table() {
    val user = reference("user", Users).primaryKey(0)
    val post = reference("post", Posts).primaryKey(1)
}