class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  include SessionsHelper

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = ""
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
    store_location
  end

  def show
    @user = User.find(params[:id])
    @micropost = Micropost.new
    @title = @user.name
    @tempfeeditems = Micropost.all
    #update each record with the latest value of activity.
    @tempfeeditems.each do |post|
      diff_seconds = (Time.now - post.updated_at).round
      diff_days = diff_seconds / 86400
      if (diff_days > 7)
        diff_days = 7
      end
      post.activity = 7 - diff_days + post.no_of_vote
      post.save
    end
    @feed_items = @user.feed.paginate(:page => params[:page])
    store_location
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
