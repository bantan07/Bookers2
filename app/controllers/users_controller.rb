class UsersController < ApplicationController
 
  def show
   @user = User.find(params[:id])
   @book = Book.new
  end
  
  def index
   @users = User.all
   @user = User.new
   @book = Book.new
  end
  
  def create
    
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "successfully"
        redirect_to user_path(@user)
    else
      @users = User.all
      render :index
    end  
  end
  
  def edit
   if params[:id] == current_user.id
    @user = User.find(params[:id])
    render action: :edit
   else
    @user = current_user
    render action: :show
   end
  end
  
  def update
   @user = User.find(params[:id])
   @user.update(user_params)
   redirect_to user_path(@user.id)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

end