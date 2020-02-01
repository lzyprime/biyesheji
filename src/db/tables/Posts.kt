package com.lzyprime.db.tables

import org.jetbrains.exposed.dao.EntityID
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.dao.IntIdTable

object Posts :IntIdTable() {
    val title = text("title")
    val content = text("content")
    val createTime = datetime("createTime")
    val updateTime = datetime("updateTime")
    val uid = reference("uid", Users)
}

class Post(id: EntityID<Int>) : IntEntity(id){
    companion object : IntEntityClass<Post>(Posts)
    var title by Posts.title
    var content by Posts.content
    var createTime by Posts.createTime
    var updateTime by Posts.updateTime
    var uid by User referencedOn Posts.uid
}