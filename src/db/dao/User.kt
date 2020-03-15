package com.lzyprime.db.dao

import com.lzyprime.db.tables.Attentions
import com.lzyprime.db.tables.FavoritePosts
import com.lzyprime.db.tables.Posts
import com.lzyprime.db.tables.Users
import org.jetbrains.exposed.dao.EntityID
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.sql.transactions.transaction

class User(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<User>(Users)

    var username by Users.username
    var password by Users.password
    var email by Users.email
    var sex by Users.sex
    var avatar by Users.avatar

    var favoritePosts by Post via FavoritePosts
    var attention by User.via(Attentions.follower, Attentions.attention)
    var follower by User.via(Attentions.attention, Attentions.follower)

    val data
        get() = mapOf(
            "id" to id.value,
            "username" to username,
            "email" to email,
            "sex" to sex,
            "avatar" to avatar,
            "post_num" to transaction {
                Post.find { Posts.uid eq id }.count()
            },
            "favorite_num" to favoritePosts.count(),
            "attention_num" to attention.count(),
            "follower_num" to follower.count()
        )

}