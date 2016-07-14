class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destory]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :delete
  def new
  	@user = User.new
  end

  def index
    # @users = User.all
    # use the paginate
     @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
  	
  end


  def create
    @user = User.new(user_params)
    if @user.save
    	log_in @user
    	flash[:success] = "Welcome to VRAppstore ! "
      	redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Update Profiles success!"
        redirect_to @user
    else
      render 'new'
    end
  end

  def destory
    User.find(params[:id]).destory
    flash[:success] = "delete user success"
    redirect_to users_url
  end



  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please login"
        redirect_to login_url
      end
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to root_url unless current_user?(@user) 

    end

    #confirm is s admin user
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
