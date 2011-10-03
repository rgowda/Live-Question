class Vote < ActiveRecord::Base
  attr_accessible :voter_id, :micropost_id
end
