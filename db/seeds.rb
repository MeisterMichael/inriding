# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

helpers = ActionController::Base.helpers

default_password = ENV['DEFAULT_PASSWORD'] || 'Test123'

User.destroy_all
SwellMedia::Category.destroy_all
SwellMedia::Article.destroy_all

bio = <<STRING
Hi, glad to know you were here. I'm Michael, newbie nutrition blogger. I like to go anywhere to hunting some food and share with other. About taste, benefit, and where you can findout a good place to eat.
STRING
short_bio = bio

admin_user = User.create( name: 'inriding', email: 'meister@spacekace.com', first_name: 'Michael', last_name: 'Ferguson', status: 'active', role: 'admin', password: default_password, short_bio: short_bio, bio: bio, properties: { "facebook_id" => 'inriding', "twitter_id" => 'inriding', "pinterest_id" => 'inriding', "instagram_id" => 'inriding', "avatar_large" => nil } )


rides = SwellMedia::Category.create( status: 'active', availability: 'anyone', name: 'Rides' )

