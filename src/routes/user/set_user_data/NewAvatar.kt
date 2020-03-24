package com.lzyprime.routes.user.set_user_data

import com.lzyprime.db.dao.User
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/new_avatar")
data class NewAvatar(val uid: Int, val avatar: String, val auth: String) {
    operator fun invoke() = transaction {
        when (val user = User.findById(uid)) {
            null -> UserError.notFoundUser
            else -> if (user.authCode != auth)
                UserError.authFailed
            else {
                user.avatar = avatar
                SuccessData()
            }
        }
    }
}