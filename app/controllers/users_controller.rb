class UsersController < ApplicationController
 
   before_action :authenticate_user!

  def show
   @user = User.find(params[:id])
   @book = Book.new
   @books = @user.books
   
  end
  
  def index
   @users = User.all
   @user = User.new
   @book = Book.new
  end
  
  def create
    @user = login(params[:name], params[:password])
    if @user
      redirect_back_or_to root_path, success: 'ログインしました'
    else
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "successfully"
        redirect_to user_path(@user.id)
    else
      flash[:notice] = "prohibited this book from being saved"
      @users = User.all
      render :index
    end  
  end
  
  def edit
   @user = User.find(params[:id])
   if @user.id == current_user.id
   else
    redirect_to user_path(current_user)
   end
  end
  
  def update
   @user = User.find(params[:id])
   if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
   else
    flash[:notice] = "error" 
     render :edit
   end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
