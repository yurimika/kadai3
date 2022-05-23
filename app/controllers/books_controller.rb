class BooksController < ApplicationController
  
  before_action :ensure_user, only: [:edit, :update, :destroy]
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[ :notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = current_user
    @book = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
   if @user == current_user
     render :edit
   else
      redirect_to books_path
   end
  end

  def update
    book = Book.find(params[:id])
  if book.update(book_params)
     flash[ :notice] = "You have update book successfully."
    redirect_to book_path(book.id)
  else
    render :edit
  end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
     flash[:notice] = "You have destroy book successfully."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:name, :body)
  end

end
