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
@Location("/favorite_posts")
data class GetFavoritePosts(val uid:Int) {
    operator fun invoke() = transaction {
        when (val user = User.findById(uid)) {
            null -> UserError.NotFoundUser
            else -> SuccessData(data = user.favoritePosts.map { it.data })
        }
    }
}