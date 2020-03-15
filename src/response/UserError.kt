package com.lzyprime.response

object UserError {
    val NotFoundUser by lazyOf(FailedData(-101, "用户不存在"))
    val WrongPassword by lazyOf(FailedData(-102, "密码错误"))
    val FiledNotNull by lazyOf(FailedData(-103, "字段不能为空"))
    val Existed by lazyOf(FailedData(-104, "已存在"))
}