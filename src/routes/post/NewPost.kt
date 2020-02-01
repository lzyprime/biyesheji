package com.lzyprime.routes.post

import com.lzyprime.db.tables.Post
import com.lzyprime.db.tables.User
import com.lzyprime.response.PostError
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction
import org.joda.time.DateTime

@KtorExperimentalLocationsAPI
@Location("/new")
data class NewPost(
    val title: String,
    val content: String,
    val uid: Int
) {
    operator fun invoke()= when {
        title.isEmpty() -> PostError.TitleNotNull
        content.isEmpty() -> PostError.ContentNotNull
        else -> transaction {
            when (val user = User.findById(uid)) {
                null -> UserError.NoUser
                else -> {
                    val now = DateTime.now()
                    Post.new {
                        title = this@NewPost.title
                        content = this@NewPost.content
                        createTime = now
                        updateTime = now
                        uid = user
                    }
                    SuccessData()
                }
            }
        }
    }
}
