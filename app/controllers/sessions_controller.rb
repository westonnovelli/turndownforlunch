class SessionsController < ApplicationController
  def new
  end

  def create
    session[:user] = "#{params[:firstName]} #{params[:lastName]}"
    redirect_to root_url, :notice => "Logged in!"
  end

  def destroy
    session[:user] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
