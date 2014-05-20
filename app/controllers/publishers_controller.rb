class PublishersController < ApplicationController

  def index

  end

  def new
    if is_admin?
      @publisher = Publisher.new
    else
      redirect_to root_path, notice: "Access Denied"
    end
  end

  def create
    @publisher = Publisher.new(publisher_params)
    if @publisher.valid?
      if @publisher.save
        redirect_to new_publisher_path, notice: "Publisher #{@publisher.name} successfully added"
      else
        render new_publisher_path, notice: "Something went wrong."
      end
    else
      redirect_to new_publisher_path, notice: "Name and City are required fields"
    end
  end

  def show
    @publisher = Publisher.find(params[:id])
  end

  private

  def publisher_params
    params.require(:publisher).permit(:city, :name)
  end
end