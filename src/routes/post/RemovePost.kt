package com.lzyprime.routes.post

import com.lzyprime.db.DB
import com.lzyprime.db.dao.Comment
import com.lzyprime.db.dao.Post
import com.lzyprime.db.dao.User
import com.lzyprime.db.tables.Comments
import com.lzyprime.db.tables.FavoritePosts
import com.lzyprime.db.tables.Posts
import com.lzyprime.response.PostError
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.deleteWhere
import org.jetbrains.exposed.sql.transactions.transaction


@KtorExperimentalLocationsAPI
@Location("/remove_post")
data class RemovePost(val uid: Int, val auth: String, val postId: Int) {

    operator fun invoke() = transaction {
        when (val user = User.findById(uid)) {
            null -> UserError.notFoundUser
            else -> if (user.authCode != auth)
                UserError.authFailed
            else when (val post = Post.findById(postId)) {
                null -> PostError.notFoundPost
                else -> if (post.user.id == user.id) {
                    Comments.deleteWhere { Comments.postId eq post.id }
                    FavoritePosts.deleteWhere { FavoritePosts.post eq post.id }
                    post.delete()
                    SuccessData()
                } else
                    PostError.removePostFailed
            }
        }
    }

}