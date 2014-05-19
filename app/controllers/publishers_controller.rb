class PublishersController < ApplicationController

  def index
    
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new(publisher_params)

    if @publisher.save
      redirect_to new_publisher_path, notice: "Publisher #{@publisher.name} successfully added"
    else
      render new_publisher_path, notice: "Something went wrong."
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