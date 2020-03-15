package com.lzyprime.db.tables

import org.jetbrains.exposed.sql.Table

object Attentions:Table() {
    val follower = reference("follower", Users).primaryKey(0)
    val attention = reference("attention", Users).primaryKey(1)
}