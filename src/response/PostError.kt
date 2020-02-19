package com.lzyprime.response

object PostError {
    val TitleNotNull by lazyOf(FailedData(-201, "标题不能为空"))
    val ContentNotNull by lazyOf(FailedData(-202, "内容不能为空"))
    val NotFoundPost by lazyOf(FailedData(-203, "文章不存在"))
    val PostUserError by lazyOf(FailedData(-204, "文章不属于该用户"))
}
