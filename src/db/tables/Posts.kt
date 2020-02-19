package com.lzyprime.db.tables

import org.jetbrains.exposed.dao.IntIdTable

object Posts :IntIdTable() {
    val title = text("title")
    val content = text("content")
    val createTime = datetime("createTime")
    val updateTime = datetime("updateTime")
    val uid = reference("uid", Users)
}
