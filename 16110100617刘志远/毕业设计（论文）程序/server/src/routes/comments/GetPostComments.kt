package com.lzyprime.routes.comments

import com.lzyprime.db.dao.Comment
import com.lzyprime.db.tables.Comments
import com.lzyprime.response.SuccessData
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/get_post_comments")
data class GetPostComments(val postId: Int) {
    operator fun invoke() = transaction {
        SuccessData(data = Comment.find { Comments.postId eq postId }.map { it.data }.toList())
    }
}