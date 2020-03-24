package com.lzyprime.routes.comments

import com.lzyprime.db.DB
import com.lzyprime.db.dao.Comment
import com.lzyprime.db.dao.Post
import com.lzyprime.db.dao.User
import com.lzyprime.response.CommentError
import com.lzyprime.response.PostError
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction
import org.joda.time.DateTime


@KtorExperimentalLocationsAPI
@Location("/new_comment")
data class NewComment(val uid: Int, val auth: String, val postId: Int, val content: String) {
    operator fun invoke() =
        if (content.isEmpty())
            CommentError.notNull
        else
            transaction(DB()) {
                when (val user = User.findById(uid)) {
                    null -> UserError.notFoundUser
                    else -> if (user.authCode != auth)
                        UserError.authFailed
                    else
                        when (val post = Post.findById(postId)) {
                            null -> PostError.notFoundPost
                            else -> {
                                val comment = Comment.new {
                                    content = this@NewComment.content
                                    dateTime = DateTime.now()
                                    this.post = post
                                    this.user = user
                                }
                                SuccessData(data = comment.data)
                            }
                        }
                }
            }
}