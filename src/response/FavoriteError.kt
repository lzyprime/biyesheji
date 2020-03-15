package com.lzyprime.response

object FavoriteError {
    val postBelongWithUser by lazy { FailedData(-301, "文章属于该用户") }
    val CannotAttentionSelf by lazy { FailedData(-302, "不能关注自己") }
}