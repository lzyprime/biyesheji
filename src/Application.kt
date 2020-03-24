package com.lzyprime

import com.lzyprime.db.DB
import com.lzyprime.routes.comments.GetPostComments
import com.lzyprime.routes.comments.GetUserComments
import com.lzyprime.routes.comments.NewComment
import com.lzyprime.routes.comments.RemoveComment
import com.lzyprime.routes.favorite.AttentionUser
import com.lzyprime.routes.favorite.FavoritePost
import com.lzyprime.routes.post.EditPost
import com.lzyprime.routes.post.PostList
import com.lzyprime.routes.post.RemovePost
import com.lzyprime.routes.user.auth.Login
import com.lzyprime.routes.user.auth.Register
import com.lzyprime.routes.user.get_user_data.*
import com.lzyprime.routes.user.set_user_data.NewAvatar
import com.lzyprime.routes.user.set_user_data.NewSex
import com.lzyprime.routes.user.set_user_data.NewUsername
import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.locations.*
import io.ktor.gson.*
import io.ktor.features.*
import io.ktor.request.uri

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
            route("/auth") {
                get<Login> { call.respond(it()) }
                get<Register> { call.respond(it()) }

                get { call.respond("/user/auth/* [login, register]") }
            }
            route("/get") {
                get<GetUserInfo> { call.respond(it()) }
                get<GetPosts> { call.respond(it()) }
                get<GetFavoritePosts> { call.respond(it()) }
                get<GetAttentions> { call.respond(it()) }
                get<GetFollowers> { call.respond(it()) }

                get { call.respond("/user/get/* [get_user_info, posts, favorite_posts, attentions, followers]") }
            }
            route("/set") {
                get<NewUsername> { call.respond(it()) }
                get<NewSex> { call.respond(it()) }
                get<NewAvatar> { call.respond(it()) }

                get { call.respond("/user/set/* [new_username, new_sex, new_avatar]") }
            }
            get {
                call.respond("/user/* [auth, get, set]")
            }
        }

        route("/post") {
            get<EditPost> { call.respond(it()) }
            get<PostList> { call.respond(it()) }
            get<RemovePost> { call.respond(it()) }

            get { call.respond("/post/* [edit_post, post_list, remove_post]") }
        }

        route("/favorite_attention") {
            get<FavoritePost> { call.respond(it()) }
            get<AttentionUser> { call.respond(it()) }
            get { call.respond("/favorite_attention/* [post, user]") }
        }

        route("/comments") {
            get<NewComment> { call.respond(it()) }
            get<GetPostComments> { call.respond(it()) }
            get<GetUserComments> { call.respond(it()) }
            get<RemoveComment> { call.respond(it()) }

            get { call.respond("/comments/* [new_comment, get_post_comments, get_user_comments, remove_comment]") }
        }

        get {
            call.respond("/* [user, post, favorite_attention, comments]")
        }
    }
}

