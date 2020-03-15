package com.lzyprime.routes.user

import com.lzyprime.db.dao.User
import com.lzyprime.response.SuccessData
import com.lzyprime.response.UserError
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.transactions.transaction


@KtorExperimentalLocationsAPI
@Location("/new_sex")
data class NewSex(val uid: Int, val sex: Int) {
    operator fun invoke() = transaction {
        when (val user = User.findById(uid)) {
            null -> UserError.NotFoundUser
            else -> {
                user.sex = sex
                SuccessData()
            }
        }
    }
}