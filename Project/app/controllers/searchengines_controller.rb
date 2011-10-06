class SearchenginesController < ApplicationController

  include SessionsHelper

  def index #get the search results from the Search Model and pass the variables to views
    redirect_back_or root_path
  end

  def create
    @query = params[:searchengine]
    results = Searchengine.SearchContent(@query["content"])
    @feed_items = results[:microposts].paginate(:page => params[:page])
    @feed_users = results[:users].paginate(:page => params[:page])
  end

end
