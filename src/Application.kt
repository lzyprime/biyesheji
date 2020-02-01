package com.lzyprime

import com.lzyprime.routes.user.userRoute
import com.lzyprime.db.DB
import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.locations.*
import io.ktor.gson.*
import io.ktor.features.*

fun main(args: Array<String>): Unit {
    DB()
    io.ktor.server.netty.EngineMain.main(args)
}

@KtorExperimentalLocationsAPI
fun Application.module(testing: Boolean = false) {
    install(Locations) {
    }

    install(ContentNegotiation) {
        gson {
        }
    }

    routing {
        userRoute()

        get {
            call.respond("/* [user, post]")
        }
    }
}

