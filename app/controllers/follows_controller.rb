class FollowsController < ApplicationController
  before_action :authenticate_user!
    before_action :set_user, except: [:index]

  def index
          @users = User.all
  end

  def follow_user
    if current_user.follow @user.id
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    end
  end

  def unfollow_user
    if current_user.unfollow @user.id
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    end
  end

  def followers
    @followers = @user.followers
  end

  def following
    @followings = @user.following
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end