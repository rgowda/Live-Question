class PagesController < ApplicationController
  include SessionsHelper

  def home
    @title = "Home"
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feedall.paginate(:page => params[:page])
    end
    store_location
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end
end
