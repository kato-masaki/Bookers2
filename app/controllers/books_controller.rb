class BooksController < ApplicationController

  def index
    @user = User.find(current_user.id) # 正しいか要確認
    @book_new = Book.new
    @books = Book.all
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      redirect_to book_path(@book_new.id), notice: 'You have created book successfully.'
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params) # @book.user_id = current_user.idは不要
     redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
     render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
