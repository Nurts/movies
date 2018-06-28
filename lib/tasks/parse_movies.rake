namespace :parse do
	desc "Parse movies"
	task :cities => :environment do
		require "nokogiri"
		require "open-uri"
		City.destroy_all
		Cinema.destroy_all
		html = Nokogiri::HTML(open("http://kino.kz/?ver=old"))
		cinema_groups = html.css(".menu_items")
		cities = html.css(".menu_city")
		i = 0
		cinema_groups.each do |cinemas|
			city = cities[i].text
			cinemas.css(".menu_item a").each do |cinema|
				id = cinema.attribute('href').to_s.split('=')[1].to_i
				c = City.new(id: i+1,name: city)
				c.save
				Cinema.create(id: id,city_id: c.id, name: cinema.text)
			end
			i += 1
		end
	end

	task :movies => :environment do
		require "nokogiri"
		require "open-uri"
		

	end

	task :sessions => :environment do
		init_time = Time.now
		require "nokogiri"
		require "open-uri"
		
		Session.destroy_all
		Movie.destroy_all
		used = {}
		i = 0
		Cinema.all.each do |cinema|
			i += 1
			html = Nokogiri::HTML(open("http://kino.kz/new/schedule_cinema?id=#{cinema.id}&sort=0&day=0&startTime=06%3A00&endTime=05%3A59"), nil, 'UTF-8')
			html.css("tbody").each do |movie|
				link = movie.css('.btn')
				next if link.empty?
				id = link.attribute('href').to_s.split('/')[3].to_i
				if used["#{id}"].nil?
					used["#{id}"] = 1
					#title = movie.css('.title').text
					#image_url = movie.css('img').attribute('src').to_s
					movie_page = Nokogiri::HTML(open("http://kino.kz/new/movie/#{id}"), nil, 'UTF-8')
					unless movie_page.css('.infoTable img').empty?
						image_url = movie_page.css('.infoTable img').attribute('src') 
					end
					title = movie_page.css('.title span').text
					description = movie_page.css('.story p').text
					Movie.create(id: id, title: title, image_url: image_url)
				end
				movie.css(".txt-rounded").each do |session|
					Session.create(movie_id: id, cinema_id: cinema.id, time: session.text)
				end
			end
		end
		end_time = Time.now
		puts (end_time - init_time).to_s
	end
end
