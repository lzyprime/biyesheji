package com.lzyprime.routes.user

import com.lzyprime.db.dao.Post
import com.lzyprime.db.dao.User
import com.lzyprime.db.tables.Posts
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/posts")
data class GetPosts(val uid: Int) {
    operator fun invoke() = transaction {
        val resultData = when (User.findById(uid)) {
            null -> UserError.NotFoundUser
            else -> {
                val posts = Post.find { Posts.uid eq uid }
                if (posts.empty())
                    SuccessData(data = emptyArray<Post>())
                else
                    SuccessData(data = posts.map { it.data })
            }
        }
        resultData
    }
}