class MicropostsController < ApplicationController
  before_filter :authenticate

  include SessionsHelper

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if (@micropost.blank? == true)
      flash[:fatal] = "Invalid Micropost!!!"
      redirect_to home_path
      return
    end

    @micropost.no_of_vote = 0
    if (@micropost.save)
      flash[:success] = "Micropost created!"
      redirect_to "/users/#{current_user.id}"
    else
      redirect_to home_path
    end
  end

  def comment
    @reply = Micropost.new
    @reply.user_id=current_user.id
    @reply.micropost_id = params[:id]
    @ruser = current_user
    @cmicropost = Micropost.find(params[:id])
    @cmicropost.touch
  end

  def vote
    @checkVote = Vote.where("voter_id = ? and micropost_id = ?", current_user.id, params[:id])
    @vpost = Micropost.where("user_id = ? and id = ?", current_user.id, params[:id])
    if (@checkVote == [] and @vpost == [])
      @vote = Vote.new
      @vote.voter_id=current_user.id
      @vote.micropost_id= params[:id]
      @vote.save
      @vmicropost = Micropost.find(params[:id])
      if (@vmicropost != [])
        @vmicropost.no_of_vote+=1
        @vmicropost.save
      end
    end
    redirect_back_or root_path
  end

  def destroy
    if current_user.admin?
      Micropost.find(params[:id]).destroy
    end
    redirect_to :back
  end

  private

  def authorized_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end
end
