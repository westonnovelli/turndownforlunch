class SessionsController < ApplicationController
  def new
  end

  def create
    user = Users.findUser(params[:firstName], params[:lastName]) if params[:firstName]+params[:lastName] != ""
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash[:alert] = "Invalid name"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
