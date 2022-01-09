class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def new
   @book = Book.new
  end
  
  def index
   @book = Book.new
   @books = Book.all
   @users = @book.user
   @user = User.new
 
  end

  def create
    @user = User.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
        redirect_to book_path(@book.id)
    else
      flash[:notice] = "error"
      @books = Book.all
      render :index
    end  
  end

  def show
   @new_book = Book.new
   @user = User.new
   @book = Book.find(params[:id])
   @users = @book.user
  end

  def edit
  @book = Book.find(params[:id])
   unless @book.user == current_user
     redirect_to books_path
   end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "successfully" 
     redirect_to book_path(@book.id)
    else
     flash[:notice] = "error" 
     render :edit
    end
  end

  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private
  def book_params
   params.require(:book).permit(:user_id, :title, :body)
  end  
  
  def ensure_correct_user
    user = Book.find(params[:id]).user
    if current_user.id != user.id
      redirect_to books_path
    end
  end
end
