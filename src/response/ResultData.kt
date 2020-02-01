package com.lzyprime.response

sealed class ResultData(val result: Int, val msg: String)
class FailedData(result:Int, msg:String): ResultData(result, msg)
data class SuccessData(val data:Any? = null): ResultData(0, "success")
