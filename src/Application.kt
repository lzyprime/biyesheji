package com.lzyprime

import com.lzyprime.db.DB
import com.lzyprime.routes.favorite.AttentionUser
import com.lzyprime.routes.favorite.FavoritePost
import com.lzyprime.routes.post.EditPost
import com.lzyprime.routes.post.PostList
import com.lzyprime.routes.user.*
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

            get<GetPosts> { call.respond(it()) }
            get<GetFavoritePosts> { call.respond(it()) }
            get<GetAttentions> { call.respond(it()) }
            get<GetFollowers> { call.respond(it()) }

            get<NewUsername> { call.respond(it()) }
            get<NewSex> { call.respond(it()) }
            get<NewAvatar> { call.respond(it()) }

            get {
                call.respond("/user/* [login, register, get_user_info, posts, favorite_posts, attentions, followers]")
            }
        }

        route("/post") {
            get<EditPost> { call.respond(it()) }
            get<PostList> { call.respond(it()) }

            get { call.respond("/post/* [edit_post, post_list]") }
        }

        route("/favorite_attention") {
            get<FavoritePost> { call.respond(it()) }
            get<AttentionUser> { call.respond(it()) }
            get { call.respond("/favorite_attention/* [post, user]") }
        }

        get {
            call.respond("/* [user, post, favorite_attention]")
        }
    }
}

