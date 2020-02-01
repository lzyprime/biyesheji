package com.lzyprime.routes.user

import com.lzyprime.db.tables.User
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction

@KtorExperimentalLocationsAPI
@Location("/get_user_info")
data class GetUserInfo(val uid: Int) {
    operator fun invoke() = transaction {
        when (val user = User.findById(uid)) {
            null -> UserError.NoUser
            else -> SuccessData(
                mapOf(
                    "id" to user.id.value,
                    "username" to user.username,
                    "email" to user.email,
                    "sex" to user.sex
                )
            )
        }
    }
}