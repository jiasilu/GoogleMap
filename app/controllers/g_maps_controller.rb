class GMapsController < ApplicationController
  respond_to :json, :html
  
  def index
    @user = User.find(session[:user_id])
    @gMaps = @user.gMaps
    @json = @gMaps.to_gmaps4rails
    @newGMap = GMap.new
    respond_with @json
  end

  def show
  end
  
  def new
  end
  
  def edit
  end

  # def showMap
  #   layout "map_layout"
  #   @users = User.all
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @users }
  #   end
  # end
=begin  
  def Create
      @user = User.find(params[:id])
      @gMap = GMap.new(params[:gMap])
      #@json = User.all.to_gmaps4rails
      if @user.nil?
        flash.now[:notice] = 'Cannot find the user!'
        render @json
      else
        if @gMap.save
          flash[:notice] = 'Submit success!'
          format.html { redirect_to @user}
          format.json { render json: @user, status: :created, location: @user }
        else 
          flash[:notice] = 'Submit fails!'
          format.html { render action: "new"}
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
        #sign_user_in(@user)
        #flash[:notice] = 'Login success!'
        #redirect_back_or user_path(@user.id)
  #      else
  #        UserMailer.deliver_confirm(@user)
  #        deny_access('Login fails! You account has not activated yet, please check your email.')
    end
  end
=end
# POST /users
# POST /users.json
  def create
    @user = User.find(session[:user_id])
    @gMap = GMap.new(params[:g_map].merge(user_id: session[:user_id], username: @user.username))

    if @gMap.save
      redirect_to :back
    else
      render text: 'Nope'
    end

    # respond_to do |format|
    #   if @gMap.save
    #     flash[:notice] = 'Submit success!'
    #     format.html { redirect_to @gMap}
    #     format.json { render json: @gMap, status: :created, location: @gMap }
    #   else 
    #     flash[:notice] = 'Submit fails!'
    #     format.html { render action: "new"}
    #     format.json { render json: @gMap.errors, status: :unprocessable_entity }
    #   end
    # end
  end
end
