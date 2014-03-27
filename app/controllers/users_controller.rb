class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(:name => params[:user][:name], :email => params[:user][:email])
    if @user.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def check_email
    @user = User.find_by_email(params[:user][:email])
    if @user
      @user = false
    else
      @user = true
    end
    respond_to do |format|
      format.json do
        render :json => @user
      end
    end
  end
end
