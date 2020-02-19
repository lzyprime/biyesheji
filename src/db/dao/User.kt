package com.lzyprime.db.dao

import com.lzyprime.db.tables.FavoritePosts
import com.lzyprime.db.tables.Users
import org.jetbrains.exposed.dao.EntityID
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass

class User(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<User>(Users)

    var username by Users.username
    var password by Users.password
    var email by Users.email
    var sex by Users.sex

    var favoritePosts by Post via FavoritePosts

    val data get() = mapOf(
        "id" to id.value,
        "username" to username,
        "email" to email,
        "sex" to sex
    )

}