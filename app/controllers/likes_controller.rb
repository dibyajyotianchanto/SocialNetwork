class LikesController < ApplicationController
    before_action :authenticate_user!

    def new
        @like =  Like.new
        @post_id = params[:post_id]
        @user_id = params[:user_id]
        @like.post_id = @post_id
        @like.user_id = @user_id

        exists = Like.where(post_id: @post_id, user_id: @user_id).count

        if(exists!=0)
            redirect_to post_path(@post_id), notice: ("You have already liked the post")
        elsif(current_user != User.find(@user_id))
            redirect_to post_path(@post_id), notice: ("Unauthorised Like request")
        else
            if @like.save
                redirect_to post_path(@post_id), notice: "Post is liked." 
            else
                redirect_to post_path(@post_id), notice: "Unable to like"
            end
        end
    end
    def create

    end

    def show

    end


    def unlike
        @like =  Like.new
        @post_id = params[:post_id]
        @user_id = params[:user_id]
        @like.post_id = @post_id
        @like.user_id = @user_id

        exists = Like.where(post_id: @post_id, user_id: @user_id).count

        if(exists==0)
            redirect_to post_path(@post_id), notice: ("Nothing to Unlike")
        elsif(current_user != User.find(@user_id))
            redirect_to post_path(@post_id), notice: ("Unauthorised Unlike request")
        else
            # @current_likes = Like.where(post_id: @post_id, user_id: @user_id)
            # redirect_to post_path(@post_id), notice: (@current_likes[0])
            @current_likes = Like.where(post_id: @post_id, user_id: @user_id)
            if @current_likes[0].destroy
                redirect_to post_path(@post_id), notice: "Post is unliked." 
            else
                redirect_to post_path(@post_id), notice: "Unable to dislike"
            end
        end
    end
end