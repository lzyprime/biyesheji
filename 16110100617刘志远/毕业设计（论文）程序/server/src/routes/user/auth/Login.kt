package com.lzyprime.routes.user.auth

import com.lzyprime.db.dao.User
import com.lzyprime.db.tables.Users
import com.lzyprime.response.*
import io.ktor.http.encodeOAuth
import io.ktor.locations.*
import org.jetbrains.exposed.sql.transactions.transaction
import org.joda.time.DateTime

@KtorExperimentalLocationsAPI
@Location("/login")
data class Login(val username: String, val password: String) {
    operator fun invoke() = transaction {
        when (val user = User.find { Users.username eq username }.firstOrNull()) {
            null -> UserError.notFoundUser
            else -> if (user.password != password)
                UserError.wrongPassword
            else {
                val authCode = "${DateTime.now()}-${username}".encodeOAuth()
                user.authCode = authCode
                SuccessData(
                    mapOf(
                        "user" to user.data,
                        "authCode" to authCode
                    )
                )
            }
        }
    }
}
