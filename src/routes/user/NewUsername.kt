package com.lzyprime.routes.user

import com.lzyprime.db.dao.User
import com.lzyprime.db.tables.Users
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/new_username")
data class NewUsername(val uid: Int, val username: String) {

    operator fun invoke() = transaction {
        when (val user = User.findById(uid)) {
            null -> UserError.NotFoundUser
            else -> if (User.find { Users.username eq username }.empty()) {
                user.username = username
                SuccessData()
            } else
                UserError.Existed
        }
    }
}