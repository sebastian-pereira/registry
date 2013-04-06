module MyVk
  module Instances
    
    class User < Instance
      attr_reader :user
      
      def changed?
        cookies = Environment.getInstance.controller.cookies
        [:_session_id, :sid, :key].each do |key|
          if cookies[key] == nil
            return true
          end
        end
        
        if !@user or Digest::MD5.hexdigest(@user.email.to_s + Digest::MD5.hexdigest(@user.password.to_s)) != cookies[:key]
          return true
        end
        
        return false
      end
      
      def reset_user
        
        cookies = Environment.getInstance.controller.cookies
        [:_session_id, :sid, :key].each do |key|
          if cookies[key] == nil
            return nil
          end
        end

        sess = ActiveRecord::Base::Session.where(:session_id => cookies[:_session_id]).first
        if sess == nil
          return nil
        end
        sess = Marshal.restore(Base64.decode64(sess.data))
        if sess["shash"]
          user = ActiveRecord::Base::BaseUser.where(:user_hash => sess["shash"]).first
          if user && Digest::MD5.hexdigest(user.email.to_s + Digest::MD5.hexdigest(user.password.to_s)) == cookies[:key]
            @user = user
          end
        end
    
      end
      
      def get
        reset_user
        @user
      end
      
      def set(user)
        cookies = Environment.getInstance.controller.cookies
        session = Environment.getInstance.controller.session
        request = Environment.getInstance.controller.request
        
        if user != nil
          cookies[:sid] = request.session_options[:id]
          session[:shash] = user.user_hash
          cookies[:key] = Digest::MD5.hexdigest(user.email.to_s + Digest::MD5.hexdigest(user.password.to_s))
          @user = user
        else
          cookies[:sid] = session[:shash] = cookies[:key] = nil
        end
      end
      
    end
  end
end