class UsersController < ApplicationController
  before_action :authenticate_user!
 
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:photos, :loves, :comments)
    @folder = Post.joins(:bookmarks).where("bookmarks.user_id=?", current_user.id).
      includes(:photos, :loves, :comments) if @user == current_user
  end
  def index
   
    if params[:term].start_with?('#')
      term = params[:term].gsub('#', '')
      @hash_tags = HashTag.where("name like ?", "%#{term}%")
      respond_to :js
    elsif params[:term].start_with?(/\w+/)
      @users = User.where("name like ?", "%#{params[:term]}%")
      @hash_tags = nil
      respond_to :js
    elsif params[:term].blank?
      @white = "white"
      respond_to :js

    else
      @users = nil
    end
  end
end