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
end
