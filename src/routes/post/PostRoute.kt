package com.lzyprime.routes.post
import io.ktor.application.call
import io.ktor.locations.KtorExperimentalLocationsAPI
import io.ktor.response.respond
import io.ktor.routing.Route
import io.ktor.routing.route
import io.ktor.locations.get
import io.ktor.routing.get

@KtorExperimentalLocationsAPI
fun Route.postRoute() = route("/post"){
    get<NewPost> { call.respond(it()) }
    get<UpdatePost> { call.respond(it()) }

    get {
        call.respond("/post/* [new, update]")
    }
}