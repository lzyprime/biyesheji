package com.lzyprime.response

object FavoriteError {
    val postBelongWithUser by lazy { FailedData(-301, "文章属于该用户") }
}