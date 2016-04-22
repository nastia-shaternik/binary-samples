class SamplesController < ApplicationController
  def index
    @samples = samples

    render json: @samples
  end

  def create
    SamplesCreationService.new.process(params[:buffer])
    render json: { message: "OK" }, status: 200
  rescue SamplesCreationService::SamplesCreationError => e
    render json: { message: e.message }, status: 422
  end

  protected
  def samples
    samples = Sample.by_sensor_id(params[:sensor_id])
    samples = samples.filter_by_start_time(params[:start_time]) if params[:start_time]
    samples = samples.filter_by_end_time(params[:end_time]) if params[:end_time]

    samples
  end
end
