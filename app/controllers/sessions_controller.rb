class SessionsController < ApplicationController
  def new
  end

  def create
    user = Users.findUser(params[:firstName], params[:lastName]) if params[:firstName]+params[:lastName] != ""
    day = Day.get_or_create(Date.today)
    if user
      session[:user_id] = user.id
      session[:day_id] = day.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash[:alert] = "Invalid name"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:day_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
