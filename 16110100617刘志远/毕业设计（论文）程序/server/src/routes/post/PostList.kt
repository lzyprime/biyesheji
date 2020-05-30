package com.lzyprime.routes.post

import com.lzyprime.db.dao.Post
import com.lzyprime.response.SuccessData
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/post_list")
data class PostList(val current: Int, val type: Int) {

    operator fun invoke() = transaction {
        SuccessData(data = Post.all().map { it.data })
    }
}