class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event, only: [:destroy]

  def index
    @events = Event.paginate(:page => params[:page], :per_page => 15).includes(:user, :likes).order("created_at desc")
    @event = Event.new
  end
  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to events_path
      flash[:notice] = "EVENT CREATE!"
    else
      flash[:alert] = "An error occured (´；ω；`)"
      redirect_to events_path
    end
  end
  
  def destroy
    if @event.user == current_user
      if @event.destroy
        flash[:notice] = "Event DELETED…"
      else
        flash[:alert] = "Something went wrong ..."
      end
    else
      flash[:notice] = "You don't have permission to do that!"
    end
    redirect_to events_path
  end

  private
  def find_event
    @event = Event.find_by id: params[:id]

    return if @event
    flash[:danger] = "Event not exist!"
    redirect_to events_path
  end

  def event_params
    params.require(:event).permit(:name, :content, :hashtag)
  end
end