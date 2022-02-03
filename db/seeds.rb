require "faker"

# Company.destroy_all
# User.destroy_all
# Critic.destroy_all
# Game.destroy_all
# InvolvedCompany.destroy_all

# # user = User.create(username: "Luffy")
# # company1 = Company.create(name: "Sony")

# company = Company.create(name: "Nintento")

# game = ""
# new_ = ""
# 2.times do |n|
#   game = Game.new
#   game.name = Faker::Game.unique.title
#   cover_url = Faker::LoremFlickr.image(size: "500x600") 
#   game.cover.attach(io: URI.open(cover_url), filename: "game-#{n}.jpg")
#   game.cover.attach(io: File.open("db/img/img.jpg"), filename: "img")
#   game.save
#   new_ = InvolvedCompany.create( game: game, company: company, publisher: true, developer: false)
# end

# puts game.errors.full_messages
# puts new_.errors.full_messages


require "json"

companies_data = JSON.parse(File.read("db/data/companies.json"))
games_data = JSON.parse(File.read("db/data/games.json"))
genres_data = JSON.parse(File.read("db/data/genres.json"))
platforms_data = JSON.parse(File.read("db/data/platforms.json"))

puts "Start seeding"

Company.destroy_all
Platform.destroy_all
Genre.destroy_all
Game.destroy_all

puts "Seeding companies"
n = 0
companies_data.each do |company_data|
  n += 1
  new_company = Company.new(company_data)
  cover_url = Faker::LoremFlickr.image(size: "500x600", search_terms: ["companygames"]) 
  new_company.cover.attach(io: URI.open(cover_url), filename: "game-#{n}.jpg")
  puts "Company not created. Errors: #{new_company.errors.full_messages}" unless new_company.save
end

puts "Seeding platforms"
platforms_data.each do |platform_data|
  new_platform = Platform.new(platform_data)
  puts "Platform not created. Errors: #{new_platform.errors.full_messages}" unless new_platform.save
end

puts "Seeding genres"
genres_data.each do |name|
  new_genre = Genre.new(name: name)
  puts "Genre not created. Errors: #{new_genre.errors.full_messages}" unless new_genre.save
end

puts "Seeding main games and relationships"

main_games_data = games_data.select {|game| game["parent"].nil? }
  n = 0
main_games_data.each do |game|
  n += 1
  game_data = game.slice("name", "summary", "release_date", "category", "rating")
  new_game = Game.new(game_data)
  cover_url = Faker::LoremFlickr.image(size: "500x600", search_terms: ["games"]) 
  new_game.cover.attach(io: URI.open(cover_url), filename: "game-#{n}.jpg")
  puts "Game not created. Errors: #{new_game.errors.full_messages}" unless new_game.save

  game["genres"].each do |genre_name|
    new_game.genres << Genre.find_by(name: genre_name)
  end

  game["platforms"].each do |platform|
    new_game.platforms << Platform.find_by(name: platform["name"])
  end

  game["involved_companies"].each do |involved_company_data|
    company = Company.find_by(name: involved_company_data["name"])

    new_involved_company = InvolvedCompany.new( game: new_game,
                                                company: company,
                                                publisher: involved_company_data["publisher"], 
                                                developer: involved_company_data["developer"]
                                              )
    puts "Involved Company not created. Errors: #{new_involved_company.errors.full_messages}" unless new_involved_company.save
  end
end

puts "Seeding expansion games and relationships"
expansions_games_data = games_data.select {|game| !game["parent"].nil? }
n = 0
expansions_games_data.each do |game|
  n += 1
  parent_game = Game.find_by(name: game["parent"])

  game_data = game.slice("name", "summary", "release_date", "category", "rating")
  new_game = Game.new(game_data)
  new_game.parent = parent_game
  cover_url = Faker::LoremFlickr.image(size: "500x600", search_terms: ["games"]) 
  new_game.cover.attach(io: URI.open(cover_url), filename: "game-#{n}.jpg")
  puts "Game not created. Errors: #{new_game.errors.full_messages}" unless new_game.save

  game["genres"].each do |genre_name|
    new_game.genres << Genre.find_by(name: genre_name)
  end

  game["platforms"].each do |platform|
    new_game.platforms << Platform.find_by(name: platform["name"])
  end

  game["involved_companies"].each do |involved_company_data|
    company = Company.find_by(name: involved_company_data["name"])

    new_involved_company = InvolvedCompany.new( game: new_game,
                                                company: company,
                                                publisher: involved_company_data["publisher"], 
                                                developer: involved_company_data["developer"]
                                              )
    puts "Involved Company not created. Errors: #{new_involved_company.errors.full_messages}" unless new_involved_company.save
  end
end
