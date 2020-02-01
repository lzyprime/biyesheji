package com.lzyprime.routes.post

import com.lzyprime.db.tables.Post
import com.lzyprime.db.tables.User
import com.lzyprime.response.PostError
import com.lzyprime.response.SuccessData
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction
import org.joda.time.DateTime

@KtorExperimentalLocationsAPI
@Location("/update")
data class UpdatePost(
    val postId: Int,
    val uid: Int,
    val title: String,
    val content: String
) {
    operator fun invoke() = when {
        title.isEmpty() -> PostError.TitleNotNull
        content.isEmpty() -> PostError.ContentNotNull
        else -> transaction {
            when (val post = Post.findById(postId)) {
                null -> PostError.NoPost
                else -> if (User.findById(uid) != post.uid) PostError.PostUserError
                else {
                    post.updateTime = DateTime.now()
                    post.title = this@UpdatePost.title
                    post.content = this@UpdatePost.content
                    SuccessData()
                }
            }
        }
    }
}