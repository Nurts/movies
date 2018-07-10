class Movie < ApplicationRecord
	has_many :sessions
	has_many :cinemas, through: :sessions

	#def cinema_ids(city_id)
	#	cinemas.where(city_id: city_id).select(:id).uniq.map{|x| x.id}
	#end

	def cinema_ids
		super.uniq
	end
end
