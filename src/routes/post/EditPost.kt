package com.lzyprime.routes.post

import com.lzyprime.db.dao.*
import com.lzyprime.response.PostError
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction
import org.joda.time.DateTime

@KtorExperimentalLocationsAPI
@Location("/edit_post")
data class EditPost(
    val id: Int = 0,
    val title: String,
    val content: String,
    val uid: Int
) {
    operator fun invoke() = when {
        title.isEmpty() -> PostError.TitleNotNull
        content.isEmpty() -> PostError.ContentNotNull
        else -> transaction {
            when (val user = User.findById(uid)) {
                null -> UserError.NotFoundUser
                else -> {
                    val now = DateTime.now()
                    val post = if (id == 0)
                        Post.new {
                            title = this@EditPost.title
                            content = this@EditPost.content
                            createTime = now
                            updateTime = now
                            uid = user
                        }
                    else
                        Post.findById(id).also {
                            it?.updateTime = now
                            it?.title = this@EditPost.title
                            it?.content = this@EditPost.content
                        }

                    if(post != null && post.uid.id.value != uid)
                        PostError.PostUserError
                    else if (post != null) SuccessData(post.data)
                    else PostError.NotFoundPost
                }
            }
        }
    }
}
