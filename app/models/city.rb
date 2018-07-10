class City < ApplicationRecord
	has_many :cinemas
	has_many :sessions, through: :cinemas
	has_many :movies, through: :cinemas
	validates :name, presence: true, uniqueness: true
end
