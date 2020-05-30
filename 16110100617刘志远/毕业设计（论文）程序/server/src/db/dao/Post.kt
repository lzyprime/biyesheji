package com.lzyprime.db.dao

import com.lzyprime.db.tables.Posts
import org.jetbrains.exposed.dao.EntityID
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass

class Post(id: EntityID<Int>) : IntEntity(id){
    companion object : IntEntityClass<Post>(Posts)
    var title by Posts.title
    var content by Posts.content
    var createTime by Posts.createTime
    var updateTime by Posts.updateTime
    var user by User referencedOn Posts.uid

    val data get() = mapOf(
        "id" to id.value,
        "title" to title,
        "content" to content,
        "createTime" to createTime.toString("yyyy-MM-dd HH:mm"),
        "updateTime" to updateTime.toString("yyyy-MM-dd HH:mm"),
        "user" to user.data,
        "sort_value" to updateTime.millis
    )
}