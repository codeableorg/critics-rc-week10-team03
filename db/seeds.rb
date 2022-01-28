require "faker"

Company.destroy_all
User.destroy_all
Critic.destroy_all
Game.destroy_all
InvolvedCompany.destroy_all

# user = User.create(username: "Luffy")
# company1 = Company.create(name: "Sony")

company = Company.create(name: "Nintento")

game = ""
new_ = ""
2.times do |n|
  game = Game.new
  game.name = Faker::Game.unique.title
  cover_url = Faker::LoremFlickr.image(size: "500x600") 
  game.cover.attach(io: URI.open(cover_url), filename: "game-#{n}.jpg")
  game.cover.attach(io: File.open("db/img/img.jpg"), filename: "img")
  game.save
  new_ = InvolvedCompany.create( game: game, company: company, publisher: true, developer: false)
end




puts game.errors.full_messages
puts new_.errors.full_messages