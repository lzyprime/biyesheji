package com.lzyprime.db.tables

import org.jetbrains.exposed.sql.ReferenceOption
import org.jetbrains.exposed.sql.Table


object FavoritePosts : Table() {
    val user = reference("user", Users, onDelete = ReferenceOption.CASCADE).primaryKey(0)
    val post = reference("post", Posts, onDelete = ReferenceOption.CASCADE).primaryKey(1)
}