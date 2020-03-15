package com.lzyprime.routes.user

import com.lzyprime.db.dao.User
import com.lzyprime.db.tables.Users
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI

import org.jetbrains.exposed.sql.or
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/register")
data class Register(
    val username: String,
    val password: String,
    val email: String
) {
    operator fun invoke() =
        if (username.isEmpty() || password.isEmpty() || email.isEmpty())
            UserError.FiledNotNull
        else
            transaction {
                if (User.find { (Users.username eq username) or (Users.email eq email) }.empty()) {
                    val user = User.new {
                        username = this@Register.username
                        password = this@Register.password
                        email = this@Register.email
                    }
                    SuccessData(user.data)
                } else
                    UserError.Existed
            }
}