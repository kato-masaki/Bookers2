class UsersController < ApplicationController
  
  def index
    @user = User.find(current_user.id) # 正しいか要確認
    @book_new = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book_new = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
