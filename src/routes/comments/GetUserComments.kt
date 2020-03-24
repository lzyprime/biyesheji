package com.lzyprime.routes.comments

import com.lzyprime.db.dao.Comment
import com.lzyprime.db.dao.User
import com.lzyprime.db.tables.Comments
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/get_user_comments")
data class GetUserComments(val uid:Int){
    operator fun invoke() = transaction {
        when(val user = User.findById(uid)){
            null -> UserError.notFoundUser
            else -> SuccessData(data = Comment.find { Comments.userId eq user.id }.map { it.data }.toList())
        }
    }
}