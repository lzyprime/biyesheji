package com.lzyprime.response

object CommentError {
    val notNull by lazy { FailedData(-401,"不能为空") }
    val notFoundComment by lazy { FailedData(-402, "未找到评论") }
    val removeCommentFailed by lazy { FailedData(-403, "评论删除失败") }
}