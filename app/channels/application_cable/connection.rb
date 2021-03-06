module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    identified_by :warden

    def connect
      self.current_user = find_verified_user
      self.warden = env["warden"]
    end


    protected

    def find_verified_user
      if verified_user = User.find_by(id: cookies.signed['user.id'])
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    # def find_verified_user
    #   current_user  =  User.find_by(id: cookies.signed[:user_id]) || User.find_by(username: cookies.permanent.signed[:username])
    #   if current_user
    #     current_user
    #   else
    #     reject_unauthorized_connection
    #   end
    # end

  end
end
