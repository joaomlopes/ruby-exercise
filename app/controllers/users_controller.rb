class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show, :new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the blog #{@user.name}"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update

    if @user.update(user_params)

      flash[:success] = "Your account was updated successfully"

      redirect_to @user

    else
      render 'edit'
    end

  end

  def show
    @user_posts = @user.posts.paginate(page: params[:page], per_page: 5).order("created_at desc")
  end

  def destroy
    @user.destroy

    flash[:danger] = "User and all posts and comments have been deleted"

    session[:user_id] = nil

    redirect_to root_path
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = "You can only edit or delete your own account"
      redirect_to root_path
    end
  end
end
