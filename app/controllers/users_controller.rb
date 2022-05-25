class UsersController < ApplicationController

  before_action :correct_user, only: [:edit, :update]


  def new
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
     @user = current_user
    @book = Book.new
    @users = User.all

  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
     flash[ :notice] = "You have update user successfully."
    redirect_to user_path(current_user.id)
   else
     render :edit
   end
  end

  private

  def correct_user
    user = User.find(params[:id])
    if current_user.id != user.id
      redirect_to user_path(current_user.id)
    end
  end

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end

end
