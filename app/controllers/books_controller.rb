class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit]
  def index
    @books = Book.all 
    @book = Book.new  
    @user = current_user
    
  end

  def show
    @book = Book.new 
    @book_show = Book.find(params[:id])  # まず、表示する本を取得
    @user = @book_show.user  # 本の持ち主を取得
    
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @user = current_user # renderでindexに行くときに使用する
    @books = Book.all # renderでindexに行くときに使用する

    @book = Book.new(book_params)
    @book.user_id = current_user.id  # 現在のユーザーIDを設定
    
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice]="You have created book successfully."
    else
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully.." 
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private
  # ストロングパラメータの設定
  
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
