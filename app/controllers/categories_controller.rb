class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :show, :destroy]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10).order("name asc")
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    @category.user = current_user

    if @category.save

      flash[:success] = "Category was successfully created"

      redirect_to categories_path

    else

      render 'new'

    end
  end

  def show

  end

  def edit

  end

  def update
    if @category.update(category_params)

      flash[:success] = "Category was successfully updated"

      redirect_to category_path(@category)

    else

      render 'edit'

    end
  end

  def destroy
    @category.destroy

    flash[:success] = "Category was successfully deleted"

    redirect_to categories_path
  end

  private
  def set_category

    @category = Category.find_by(id: params[:id])

  end
  def category_params
    params.require(:category).permit(:name, :user)
  end
end
