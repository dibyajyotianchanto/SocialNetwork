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

    # def redirect_to_back(default = root_url)
    #       redirect_to :back
    # end

end