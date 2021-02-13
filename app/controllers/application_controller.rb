class ApplicationController < ActionController::Base
    public

    def test_post_visibility(post)
    if(post.visibility == 1)
        return true
    end

      if !authenticate_user!
        return false
      end
      if post.user_id == current_user.id
        return true
      end

      if(post.visibility == 0)
          friendship_a = Friendship.where(sender_id: post.user_id, receiver_id: current_user.id, status:1)
          friendship_b = Friendship.where(sender_id: current_user.id, receiver_id: post.user_id, status:1)
          if friendship_a.size()>0 || friendship_b.size()>0
              return true
          else
              return false
          end
      end
    end

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
      def configure_permitted_parameters
         devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
         devise_parameter_sanitizer.permit(:account_update, keys: [:fullname])
      end
end
