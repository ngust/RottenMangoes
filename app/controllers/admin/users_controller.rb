class Admin::UsersController < ApplicationController
  before_filter :restrict_access
  before_filter :restrict_admin_access

  def index
    @users = User.all
    @users = User.order("firstname").page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    UserMailer.delete_email(@user).deliver
    redirect_to admin_users_path
  end

  def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
          redirect_to '/admin'
        else
          render :edit
        end
      end
  
  private

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
