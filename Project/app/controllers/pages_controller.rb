class PagesController < ApplicationController
  include SessionsHelper

  def home
    @title = "Home"
    if signed_in?
      @micropost = Micropost.new
      @tempfeeditems = Micropost.all
      #update each record with the latest value of activity.
      @tempfeeditems.each do |post|
        diff_seconds = (Time.now - post.updated_at).round
        diff_days = diff_seconds / 86400
        if(diff_days > 7)
          diff_days = 7
        end
        post.activity = 7 - diff_days + post.no_of_vote
        post.save
      end
      @feed_items = current_user.feedAll.paginate(:page => params[:page])
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
  def report
  end
  def reportusr
    @title = "User Reports"
    @feed_users = current_user.feeduserreport.paginate(:page => params[:page])
  end
  def reportmpt
    @title = "Micropost Reports"
    @feed_items = current_user.feedmicropostreport.paginate(:page => params[:page])
  end
end
