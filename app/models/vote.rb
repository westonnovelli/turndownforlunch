class Vote < ActiveRecord::Base

  def new(user, suggestion)
    save
  end
end
