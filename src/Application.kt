package com.lzyprime

import com.lzyprime.db.DB
import com.lzyprime.routes.favorite.FavoritePost
import com.lzyprime.routes.post.EditPost
import com.lzyprime.routes.post.PostList
import com.lzyprime.routes.routeManager
import com.lzyprime.routes.user.GetUserInfo
import com.lzyprime.routes.user.Login
import com.lzyprime.routes.user.Register
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
        route("/user") {
            get<Login> { call.respond(it()) }
            get<Register> { call.respond(it()) }
            get<GetUserInfo> { call.respond(it()) }

            get {
                call.respond("/user/* [login, register, get_user_info]")
            }
        }

        route("/post") {
            get<EditPost> { call.respond(it()) }
            get<PostList> { call.respond(it()) }

            get { call.respond("/post/* [edit_post, post_list]") }
        }

        route("/favorite") {
            get<FavoritePost> { call.respond(it()) }
            get { call.respond("/favorite/* [post]") }
        }

        get {
            call.respond("/* [user, post, favorite]")
        }
    }
}

