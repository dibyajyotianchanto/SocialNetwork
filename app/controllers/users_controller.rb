class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        all_posts = @user.posts
        @posts = []
        for post in all_posts do
            if test_post_visibility(post)
                @posts.append(post)
            end
        end
    end
end