class LovesController < ApplicationController
  before_action :authenticate_user!

  def create
    @love = current_user.loves.build(love_params)
    @post = @love.post
    if @love.save
      respond_to :js
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  def destroy
    @love = Love.find(params[:id])
    @post = @love.post
    if @love.destroy
      respond_to :js
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  private
  def love_params
    params.permit :post_id
  end
end