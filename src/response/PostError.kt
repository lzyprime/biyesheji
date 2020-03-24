package com.lzyprime.response

object PostError {
    val titleNotNull by lazyOf(FailedData(-201, "标题不能为空"))
    val contentNotNull by lazyOf(FailedData(-202, "内容不能为空"))
    val notFoundPost by lazyOf(FailedData(-203, "文章不存在"))
    val postUserError by lazyOf(FailedData(-204, "文章不属于该用户"))
    val removePostFailed by lazy { FailedData(-205, "文章删除失败") }
}
