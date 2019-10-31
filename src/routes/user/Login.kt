package com.lzyprime.routes.user

import com.lzyprime.daos.User
import com.lzyprime.tables.Users
import io.ktor.locations.*
import org.jetbrains.exposed.sql.transactions.transaction

@Location("/login")
data class Login(val username: String, val password: String) {
    operator fun invoke(): Map<String, Any> {
        val user = transaction {
            User.find { (Users.username eq username) }.firstOrNull()
        }

        return when {
            user == null -> mapOf("result" to false, "info" to "用户不存在")
            user.password == password -> mapOf("result" to true, "info" to "登录成功")
            else -> mapOf("result" to false, "info" to "密码错误")
        }

    }
}
