class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  def login_required
    deny_access unless signed_in?
  end

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

  def sign_user_in(user)
    sign_in(user)
  end

  def sign_in(user)
    if user
      session[:user_id] = user.id
    end
  end

  def redirect_back_or(default)
    session[:return_to] ||= params[:return_to]
    if session[:return_to] 
      redirect_to(session[:return_to])
    else 
      redirect_to(default)
    end
    session[:return_to] = nil
  end

  def store_location
    session[:return_to] = request.request_uri if request.get?
  end

  def deny_access(flash_message = nil, opts = {})
    store_location
    flash.now[:failure] = flash_message if flash_message
    render :template => "/sessions/new", :status => :unauthorized 
  end

end
