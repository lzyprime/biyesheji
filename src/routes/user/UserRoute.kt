package com.lzyprime.routes.user

import io.ktor.application.call
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.locations.get
import io.ktor.response.respond
import io.ktor.routing.Route
import io.ktor.routing.get
import io.ktor.routing.route

@KtorExperimentalLocationsAPI
fun Route.userRoute() = route("/user") {
    get<Login> { call.respond(it()) }

    get<Register> { call.respond(it()) }

    get<GetUserInfo> { call.respond(it()) }
    get {
        call.respond("/user/* [login, register, get_user_info]")
    }
}