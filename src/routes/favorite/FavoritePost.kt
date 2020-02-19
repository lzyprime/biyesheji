package com.lzyprime.routes.favorite

import com.lzyprime.db.dao.Post
import com.lzyprime.db.dao.User
import com.lzyprime.response.FavoriteError
import com.lzyprime.response.PostError
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.SizedCollection
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/post")
data class FavoritePost(val uid: Int, val pid: Int, val inquire: Boolean = false) {
    operator fun invoke() = transaction {
        when (val post = Post.findById(pid)) {
            null -> PostError.NotFoundPost
            else -> if (post.uid.id.value == uid)
                FavoriteError.postBelongWithUser
            else when (val user = User.findById(uid)) {
                null -> UserError.NotFoundUser
                else -> {
                    val isFavoritePost = user.favoritePosts.any { it == post }
                    if (!inquire && isFavoritePost)
                        user.favoritePosts =
                            SizedCollection(user.favoritePosts.toMutableList().also { it.remove(post) })
                    else if (!inquire && !isFavoritePost)
                        user.favoritePosts = SizedCollection(user.favoritePosts.toMutableList().also { it.add(post) })

                    SuccessData(data = user.favoritePosts.any { it == post })
                }
            }
        }
    }
}