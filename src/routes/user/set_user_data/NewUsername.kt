package com.lzyprime.routes.user.set_user_data

import com.lzyprime.db.dao.User
import com.lzyprime.db.tables.Users
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/new_username")
data class NewUsername(val uid: Int, val username: String, val auth:String) {

    operator fun invoke() = transaction {
        when (val user = User.findById(uid)) {
            null -> UserError.notFoundUser
            else -> when {
                user.authCode != auth -> UserError.authFailed
                User.find { Users.username eq username }.empty() -> {
                    user.username = username
                    SuccessData()
                }
                else -> UserError.existed
            }
        }
    }
}