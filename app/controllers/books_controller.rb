class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def show
    @hon = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
    @this_week_book = @books.created_this_week
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @book_3 = @books.created_3
    @book_4 = @books.created_4
    @book_5 = @books.created_5
    @book_6 = @books.created_6
    @book_7 = @books.created_7
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
    else
    redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
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
