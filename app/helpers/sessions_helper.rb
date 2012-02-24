module SessionsHelper
  def signed_in?
    !current_user.nil?
  end
  def current_user
    @_current_user ||= user_from_session
  end

  def user_from_session
    if session[:user_id]
      user = User.find_by_id(session[:user_id])
#      user && user.activated? ? user : nil                
    end
  end
end
