class PagesController < ApplicationController
  def index
    @loves = Love.where(created_at: Time.current.all_week)
    @rank = Post.find(@loves.group(:post_id).order('count(post_id) desc').limit(12).pluck(:post_id))
  end
  
  
  def show
    @posts = Post.joins(:hash_tags).where(hash_tags: {id:params[:id]}).includes(:photos)
  end
end