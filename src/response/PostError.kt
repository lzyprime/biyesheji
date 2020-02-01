package com.lzyprime.response

object PostError {
    val TitleNotNull by lazyOf(FailedData(-1, "标题不能为空"))
    val ContentNotNull by lazyOf(FailedData(-2, "内容不能为空"))
    val NoPost by lazyOf(FailedData(-3, "文章不存在"))
    val PostUserError by lazyOf(FailedData(-4, "文章不属于该用户"))
}
