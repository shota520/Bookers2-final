 class BooksController < ApplicationController

before_action :authenticate_user!
before_action :ensure_correct_user, only: [:edit]


  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
   end



  def create
    @books = Book.all
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
  	if @book.save
      flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book.id)
  else
    render :index
  end
  end


  def show
    @userbook = Book.find(params[:id])
    @book = Book.new
  end


  def edit
    @userbook = Book.find(params[:id])
    @user = @userbook.user
  end


  def update
    @userbook = Book.find(params[:id])
    if @userbook.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@userbook.id)
  else
    render :edit
  end
  end


  def destroy
    @userbook = Book.find(params[:id])
    @userbook.destroy
    redirect_to books_path
  end


 private

  def book_params
  	params.require(:book).permit(:title,:body)
  end

  def ensure_correct_user
    @userbook = Book.find(params[:id])
    if @userbook.user.id != current_user.id
      redirect_to books_path
  end

end
end
