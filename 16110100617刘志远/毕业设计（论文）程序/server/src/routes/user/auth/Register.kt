package com.lzyprime.routes.user.auth

import com.lzyprime.db.dao.User
import com.lzyprime.db.tables.Users
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.http.encodeOAuth
import io.ktor.locations.KtorExperimentalLocationsAPI

import org.jetbrains.exposed.sql.or
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction
import org.joda.time.DateTime

@KtorExperimentalLocationsAPI
@Location("/register")
data class Register(
    val username: String,
    val password: String,
    val email: String,
    val sex: Int,
    val avatar: String
) {
    operator fun invoke() =
        if (username.isEmpty() || password.isEmpty() || email.isEmpty())
            UserError.filedNotNull
        else transaction {
            if (User.find { (Users.username eq username) or (Users.email eq email) }.empty()) {
                val user = User.new {
                    username = this@Register.username
                    password = this@Register.password
                    sex = this@Register.sex
                    email = this@Register.email
                    avatar = this@Register.avatar
                    authCode = "${DateTime.now()}-${username}".encodeOAuth()
                }

                SuccessData(
                    data = mapOf(
                        "user" to user.data,
                        "authCode" to user.authCode
                    )
                )
            } else
                UserError.existed
        }
}
