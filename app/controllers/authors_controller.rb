class AuthorsController < ApplicationController

  def new
    if is_admin?
      @author = Author.new
    else
      redirect_to root_path, notice: "Access Denied"
    end
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to new_author_path, notice: "Author #{@author.first_name} #{@author.last_name} successfully added"
    else
      render new_author_path, notice: "Something went wrong."
    end
  end

  def show
    @author = Author.find(params[:id])
  end


  private

  def author_params
    params.require(:author).permit(:first_name, :last_name, :bio)
  end
end