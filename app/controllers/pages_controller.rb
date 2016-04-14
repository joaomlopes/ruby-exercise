class PagesController < ApplicationController
  def index
    @posts = Post.order("created_at desc").limit(6)
  end

  def about

  end

  def exercise

  end

end
