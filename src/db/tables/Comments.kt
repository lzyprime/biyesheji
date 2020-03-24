package com.lzyprime.db.tables

import org.jetbrains.exposed.dao.IntIdTable
import org.jetbrains.exposed.sql.ReferenceOption

object Comments : IntIdTable() {
    val content = varchar("content", 1000)
    val dateTime = datetime("dateTime")
    val postId = reference("postId", Posts, onDelete = ReferenceOption.CASCADE)
    val userId = reference("userId", Users, onDelete = ReferenceOption.CASCADE)
}