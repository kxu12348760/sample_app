class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :cannot_delete_current_admin, only: :destroy
  before_filter :signed_in_already, only: [:new, :create]

  def promote
    @user = User.find(params[:id])
    @user.admin = true

    if @user.save(:validate => false)
      flash[:success] = @user.name + " has been successfully promoted to an admin!"
    else
      flash[:error] = @user.name + " could not be promoted to an admin!"
    end
    redirect_to users_path
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
    numUsers = User.count
    if numUsers == 0
      @user.admin = true
    end
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page], :order => 'id ASC')
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def signed_in_already
      if signed_in?
        redirect_to root_path
      end
    end

    def cannot_delete_current_admin
      if User.find(params[:id]) == current_user
        redirect_to users_path, notice: "A user cannot delete himself"
      end
    end
end
