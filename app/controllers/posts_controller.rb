class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.includes(:photos, :user).order("created_at desc")
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      if params[:images]
        params[:images].each do |img|
          @post.photos.create(image: params[:images][img])
        end
      end

      redirect_to posts_path
      flash[:notice] = "Success !"
    else
      flash[:alert] = "An error occured (´；ω；`)"
      redirect_to posts_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @photos = @post.photos
  end


  private


  def post_params
    params.require(:post).permit :content
  end
end