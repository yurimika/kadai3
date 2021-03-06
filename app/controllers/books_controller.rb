class BooksController < ApplicationController

 before_action :correct_user, only: [:edit, :update]

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
    @books = Book.find(params[:id])
    @user = @books.user
    @book = Book.new

  end

  def edit
    @book = Book.find(params[:id])
   if @book.user != current_user
      redirect_to books_path
   end
  end

  def update
    @book = Book.find(params[:id])
  if @book.update(book_params)
     flash[ :notice] = "You have update book successfully."
    redirect_to book_path(@book.id)
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
  
   def correct_user
    book = Book.find(params[:id])
    user = book.user
    if current_user.id != user.id
      redirect_to books_path
    end
   end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
