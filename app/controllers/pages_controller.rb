class PagesController < ApplicationController
  def index
    @loves = Love.where(created_at: Time.current.all_week)
    @rank = Post.find(@loves.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end
  
  
  def show
    @posts = Post.joins(:hash_tags).where(hash_tags: {id:params[:id]}).paginate(:page => params[:page], :per_page => 5).includes(:photos, :user, :loves).
      order("created_at desc")
    @hash_tag = HashTag.find(params[:id])
  end
end