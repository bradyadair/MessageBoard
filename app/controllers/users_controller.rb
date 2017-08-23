class UsersController < ApplicationController
  def new 
  	@user = User.new	
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def show
    @current_user ||= User.find_by(id: session[:user_id])
    @user = User.find(params[:id])

    if @current_user != @user
      redirect_to @current_user #:text => @current_user.username + " is not allowed access to this user"
    end
  end

  private
  	def user_params
  		params.require(:user).permit(:username, :email, :password, :password_confirmation)
  	end
end
