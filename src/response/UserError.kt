package com.lzyprime.response

object UserError {
    val notFoundUser by lazyOf(FailedData(-101, "用户不存在"))
    val wrongPassword by lazyOf(FailedData(-102, "密码错误"))
    val filedNotNull by lazyOf(FailedData(-103, "字段不能为空"))
    val existed by lazyOf(FailedData(-104, "已存在"))
    val authFailed by lazy { FailedData(-105,"登录过期") }
}