package com.lzyprime.db.dao

import com.lzyprime.db.tables.Comments
import org.jetbrains.exposed.dao.EntityID
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass

class Comment(id:EntityID<Int>):IntEntity(id) {
    companion object : IntEntityClass<Comment>(Comments)
    var content by Comments.content
    var dateTime by Comments.dateTime
    var post by Post referencedOn  Comments.postId
    var user by User referencedOn Comments.userId

    val data get() = mapOf(
        "id" to id.value,
        "content" to content,
        "dateTime" to dateTime.toString("yyyy-MM-dd HH:mm"),
        "post" to post.data,
        "user" to user.data
    )
}