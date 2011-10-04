class Searchengine < ActiveRecord::Base
  attr_accessible :content

  def self.SearchContent(query)
    posts = users = []

    if !query.nil? and !(query.to_s == '')
      posts = Micropost.find(:all, :conditions => "content like '%#{query}%'")
      users = User.find(:all, :conditions => "name like '%#{query}%'")
    end

    hash = {:microposts => posts, :users => users}
    hash
  end
end
