class UsersController < ApplicationController




  def new
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
   if @user == current_user
     render :edit
   else
      redirect_to user_path(current_user)
   end
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
  def user_params
    params.require(:user).permit(:profile_image, :name, :Body)
  end

end
