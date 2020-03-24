package com.lzyprime.db.tables

import org.jetbrains.exposed.sql.ReferenceOption
import org.jetbrains.exposed.sql.Table

object Attentions : Table() {
    val follower = reference("follower", Users, onDelete = ReferenceOption.CASCADE).primaryKey(0)
    val attention = reference("attention", Users, onDelete = ReferenceOption.CASCADE).primaryKey(1)
}