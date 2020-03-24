package com.lzyprime.routes.comments

import com.lzyprime.db.dao.Comment
import com.lzyprime.db.dao.User
import com.lzyprime.db.tables.Comments
import com.lzyprime.response.CommentError
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/remove_comment")
data class RemoveComment(val uid: Int, val auth: String, val commentId: Int) {

    operator fun invoke() = transaction {
        when (val user = User.findById(uid)) {
            null -> UserError.notFoundUser
            else -> if (user.authCode != auth)
                UserError.authFailed
            else when (val comment = Comment.findById(commentId)) {
                null -> CommentError.notFoundComment
                else -> when (user.id) {
                    comment.user.id -> {
                        comment.delete()
                        SuccessData()
                    }
                    comment.post.user.id -> {
                        comment.delete()
                        SuccessData()
                    }
                    else -> CommentError.removeCommentFailed
                }
            }
        }
    }
}
