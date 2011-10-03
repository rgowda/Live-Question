class MicropostsController < ApplicationController
  before_filter :authenticate

  include SessionsHelper

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_back_or "/users/#{current_user.id}"
    else
      render 'pages/home'
    end
  end

  def comment
    @reply = Micropost.new
    @reply.user_id=current_user.id
    @ruser = current_user
  end




  def destroy
    Micropost.find(params[:id]).destroy
    redirect_back_or root_path
  end

  private

  def authorized_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end
end
