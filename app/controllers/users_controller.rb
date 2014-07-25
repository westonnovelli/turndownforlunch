class UsersController < ApplicationController
  before_action: only: [:suggestion]

  def index
  end

  def suggestion
  	@user.suggestion
  end

  def make_suggestion (suggestion)
  	@user.make_suggestion suggestion
  end

  def undo_suggestion
  	@user.make_suggestion
  end 

  private
  def set_user
  	@user = Users.find(params[:id])
  end
end
