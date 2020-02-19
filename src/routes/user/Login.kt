package com.lzyprime.routes.user

import com.lzyprime.db.dao.User
import com.lzyprime.db.tables.Users
import com.lzyprime.response.*
import io.ktor.locations.*
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/login")
data class Login(val username: String, val password: String) {
    operator fun invoke() = transaction {
        when (val user = User.find { Users.username eq username }.firstOrNull()) {
            null -> UserError.NotFoundUser
            else -> if (user.password != password)
                UserError.WrongPassword
            else
                SuccessData(user.data)
        }
    }
}
