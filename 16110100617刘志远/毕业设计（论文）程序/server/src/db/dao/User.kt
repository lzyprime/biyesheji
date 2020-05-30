package com.lzyprime.db.dao

import com.lzyprime.db.tables.*
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
    var authCode by Users.authCode

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
            "postNum" to transaction {
                Post.find { Posts.uid eq id }.count()
            },
            "favoriteNum" to favoritePosts.count(),
            "attentionNum" to attention.count(),
            "followerNum" to follower.count(),
            "commentNum" to transaction {
                Comment.find { Comments.userId eq id }.count()
            }
        )

}