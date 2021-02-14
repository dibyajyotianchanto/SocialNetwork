require 'byebug'
class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def acceptfriendship
        @user_id = params[:user_id]
        @current_user_id = current_user.id
        @friendship_a = Friendship.where(sender_id: @current_user_id, receiver_id: @user_id)
        @friendship_b = Friendship.where(sender_id: @user_id, receiver_id: @current_user_id)
        if(@friendship_a.size()==0 && @friendship_b.size()==1)
            Friendship.where(sender_id: @user_id, receiver_id: @current_user_id).update_all(status: 1)
            redirect_to user_path(@user_id)
        else
            redirect_to user_path(@user_id)
        end
    end

    def rejectfriendship
        @user_id = params[:user_id]
        @current_user_id = current_user.id
        @friendship_a = Friendship.where(sender_id: @current_user_id, receiver_id: @user_id)
        @friendship_b = Friendship.where(sender_id: @user_id, receiver_id: @current_user_id)
        if(@friendship_a.size()==0 && @friendship_b.size()==1)
            Friendship.where(sender_id: @user_id, receiver_id: @current_user_id).destroy_all
            redirect_to user_path(@user_id)
        else
            redirect_to user_path(@user_id)
        end
    end

    def sendfriendship
        @user_id = params[:user_id]      
        @current_user_id = current_user.id
        @friendship_a = Friendship.where(sender_id: @current_user_id, receiver_id: @user_id)
        @friendship_b = Friendship.where(sender_id: @user_id, receiver_id: @current_user_id)
        if(@friendship_a.size()==0 && @friendship_b.size()==0)
            @friendship = Friendship.new
            @friendship.sender_id = @current_user_id
            @friendship.receiver_id = @user_id
            @friendship.status = 0
            @friendship.save
            redirect_to user_path(@user_id)
        else
            redirect_to user_path(@user_id)
        end
    end

    def unsendfriendship
        @user_id = params[:user_id]
        @current_user_id = current_user.id
        @friendship_a = Friendship.where(sender_id: @current_user_id, receiver_id: @user_id)
        @friendship_b = Friendship.where(sender_id: @user_id, receiver_id: @current_user_id)
        if(@friendship_a.size()==1 && @friendship_b.size()==0)
            Friendship.where(sender_id: @current_user_id, receiver_id: @user_id).destroy_all
            redirect_to user_path(@user_id)
        else
            redirect_to user_path(@user_id)
        end
    end

    def unfriendfriendship
        @user_id = params[:user_id]
        @current_user_id = current_user.id
        Friendship.where(sender_id: @current_user_id, receiver_id: @user_id).destroy_all
        Friendship.where(sender_id: @user_id, receiver_id: @current_user_id).destroy_all
        redirect_to user_path(@user_id)
    end

    def friendlist
        @user_id = params[:user_id]
        @first = Friendship.where(sender_id: @user_id, status:1).select('receiver_id')
        @second = Friendship.where(receiver_id: @user_id, status:1).select('sender_id')
        @users = []
        for friendship in @first do
            @users.append(User.find(friendship.receiver_id))
        end

        for friendship in @second do
            @users.append(User.find(friendship.sender_id))
        end
    end

    def allfriendrequest
        @friend_requests = Friendship.where(receiver_id: current_user.id, status:0).select('sender_id')
        @users = []
        for friendship in @friend_requests do
            @users.append(User.find(friendship.sender_id))
        end
    end

    def searchpeople
        session[:return_to] ||= request.referer
        @search = params[:search].squish
        if @search==""
            redirect_to session.delete(:return_to)
        end
        @users = User.where("fullname like ?", "%#{@search}%")
    end

    # def redirect_to_back(default = root_url)
    #       redirect_to :back
    # end

end