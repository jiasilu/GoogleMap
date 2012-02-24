class UsersController < ApplicationController
  
  respond_to :json, :html
  
  # Activate
  def activate
    if @user = User.find_by_activation_token(params[:token])
      if !@user.activated?
        @user.email_confirm!
        flash.now[:notice] = "Activation success!"
      end
    end
  end
  
  # GET /users
  # GET /users.json
  
  def index
    @users = User.all
#    @json = User.all.to_gmaps4rails
    @json = GMap.all.to_gmaps4rails

    respond_with @json
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create     
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        sign_user_in(@user)
        flash[:notice] = 'Registration success!'
        format.html { redirect_to @user}
        format.json { render json: @user, status: :created, location: @user }
      else 
        flash[:notice] = 'Registration fails!'
        format.html { render action: "new"}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
