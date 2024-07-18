# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create!(first_name: 'John', last_name: 'Doe', user_name: 'admin', email: 'admin@voyager.com', password: 'admin123')
user.add_role(:admin) if user

Role.find_or_create_by(name: 'end_user')
