class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def new
   @book = Book.new
  end
  
  def index
   @books = Book.all
   @book = Book.new
   @user = User.new
   @user = User.all
   
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
        redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end  
  end

  def show
   @book = Book.find(params[:id])
   @user = User.new
   
  end

  def edit
  @book = Book.find(params[:id])
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
   params.require(:book).permit(:title, :body)
  end  
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
