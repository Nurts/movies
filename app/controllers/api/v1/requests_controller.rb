class Api::V1::RequestsController < ApplicationController
  before_action :find_city, except: [:cities]
  def cities
    cities = City.all
    render json: cities, only: [:name, :id]
  end

  def cinemas
    render json: @city.cinemas, only: [:name, :id]
  end

  def movies
    render json: @city.movies, except: [:created_at, :updated_at], methods: :cinema_ids
  end

  def sessions
    render json: @city.sessions, except: [:created_at, :updated_at]
  end

  def movie_sessions
    sessions = @city.sessions.where(movie_id: params[:movie_id])
    render json: sessions, except: [:created_at, :updated_at]
  end

  private
  def find_city
    @city = City.find(params[:id])
  end

end
