package com.lzyprime.routes.user

import com.lzyprime.daos.User
import com.lzyprime.tables.DB
import com.lzyprime.tables.Users
import io.ktor.locations.Location
import org.jetbrains.exposed.sql.or
import org.jetbrains.exposed.sql.transactions.transaction

@Location("/register")
data class Register(
    val username: String,
    val password: String,
    val email: String,
    val sex: Int
) {

    operator fun invoke(): Map<String, Any> {
        val res = if (username.isEmpty() ||
            password.isEmpty() ||
            email.isEmpty() ||
            transaction(DB()) {
                User.find { (Users.username eq username) or (Users.email eq email) }.empty().not()
            }
        ) false
        else transaction(DB()) {
            User.new {
                username = this@Register.username
                password = this@Register.password
                email = this@Register.email
                sex = this@Register.sex
            }
            true
        }

        return mapOf("result" to res, "info" to if (res) "注册成功" else "注册失败：用户名或邮箱已存在")
    }
}