class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def edit
  end

  def update
    is_myself = current_user == @user
    if @user.update(user_params)
      if is_myself && params[:user][:password].present?
        sign_in @user, :bypass => true
      end
      redirect_to users_url, notice: '正常にユーザ情報が更新されました。'
    else
      render :edit
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    end
    params.require(:user).permit(:name, :email, :user_type, :password, :password_confirmation)
  end
end
