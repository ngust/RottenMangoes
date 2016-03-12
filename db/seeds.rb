# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def convert_to_yml(yml_file)
 YAML.load_file(File.absolute_path(yml_file))
end

user_yml = convert_to_yml('db/data/users.yml')

user_yml.each_pair do |name, info|
 User.create!(
   firstname: name,
   email: info["email"],
   password: info["password"],
   lastname: info["lastname"],
   password_confirmation: info["password_confirmation"]
 )
end

movies_yml = convert_to_yml('db/data/movies.yml')

movies_yml.each_pair do |name, info|
 Movie.create!(
   title: name,
   director: info["director"],
   runtime_in_minutes: info["runtime_in_minutes"],
   description: info["description"],
   poster_image_url: info["poster_image_url"],
   release_date: info["release_date"]
 )
end
