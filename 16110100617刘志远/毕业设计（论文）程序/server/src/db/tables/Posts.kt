package com.lzyprime.db.tables

import org.jetbrains.exposed.dao.IntIdTable
import org.jetbrains.exposed.sql.ReferenceOption

object Posts : IntIdTable() {
    val title = text("title")
    val content = text("content")
    val createTime = datetime("createTime")
    val updateTime = datetime("updateTime")
    val uid = reference("uid", Users, onDelete = ReferenceOption.CASCADE)
}
