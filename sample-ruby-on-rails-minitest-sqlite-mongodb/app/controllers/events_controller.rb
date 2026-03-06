class EventsController < ApplicationController
  before_action :set_event, only: %i[show update destroy]

  def index
    render json: Event.all
  end

  def show
    render json: @event
  end

  def create
    event = Event.new(event_params)
    if event.save
      render json: event, status: :created
    else
      render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    head :no_content
  end

  private

  def set_event
    @event = Event.find(params[:id])
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: "Event not found" }, status: :not_found
  end

  def event_params
    params.expect(event: [:name, :category, { metadata: {} }])
  end
end
