module SessionsHelper
  def set_cookie(user)
    username = user.username.to_s
    cookies.permanent.signed[:username] = username
  end
end
