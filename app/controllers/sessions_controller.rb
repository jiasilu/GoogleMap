class SessionsController < ApplicationController
  def new 
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user.nil?
      flash.now[:notice] = 'Login fails! Wrong email or password.'
      render :action => :new, :status => :unauthorized
    else
#      if @user.activated?
        sign_user_in(@user)
        flash[:notice] = 'Login success!'
        redirect_back_or user_path(@user.id)
#      else
#        UserMailer.deliver_confirm(@user)
#        deny_access('Login fails! You account has not activated yet, please check your email.')
    end
  end
  
  def destroy
    reset_session
    flash[:notice] = "You have successfully logged out!"
    redirect_to users_path
  end
end
