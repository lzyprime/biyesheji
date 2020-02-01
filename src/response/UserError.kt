package com.lzyprime.response

object UserError {
    val NoUser by lazyOf(FailedData(-1, "用户不存在"))
    val WrongPassword by lazyOf(FailedData(-2, "密码错误"))
    val FiledNotNull by lazyOf(FailedData(-3, "字段不能为空"))
    val Existed by lazyOf(FailedData(-4, "用户名或邮箱已存在"))
}