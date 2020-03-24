package com.lzyprime.routes.favorite

import com.lzyprime.db.dao.User
import com.lzyprime.response.FavoriteError
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.SizedCollection
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/user")
data class AttentionUser(val uid: Int, val otherUid: Int, val inquire: Boolean = false) {

    operator fun invoke() = if (uid == otherUid) FavoriteError.cannotAttentionSelf else transaction {
        val user = User.findById(uid)
        val other = User.findById(otherUid)
        if (user == null || other == null)
            UserError.notFoundUser
        else if (inquire)
            SuccessData(data = user.attention.any { it == other })
        else when (user.attention.any { it == other }) {
            true -> {
                user.attention = SizedCollection(user.attention.toMutableList().also { it.remove(other) })
                SuccessData(data = false)
            }
            false -> {
                user.attention = SizedCollection(user.attention.toMutableList().also { it.add(other) })
                SuccessData(data = true)
            }
        }
    }
}