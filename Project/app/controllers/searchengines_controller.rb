class SearchenginesController < ApplicationController

  include SessionsHelper

  def index #get the search results from the Search Model and pass the variables to views
    @searchengine = Searchengine.new
  end

  def create
    @query = params[:searchengine]
    results = Searchengine.SearchContent(@query["content"])
    @feed_microposts = results[:microposts].paginate(:page => params[:page])
    @feed_users = results[:users].paginate(:page => params[:page])
  end

end
