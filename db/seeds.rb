# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
AdminUser.create(email: 'matthew@ait.asia', password: 'Fullstack@6', password_confirmation: 'Fullstack@6') if Rails.env.development?
AdminUser.create(email: 'cedric@cait.asia', password: 'cedric@team6', password_confirmation: 'cedric@team6') if Rails.env.development?
AdminUser.create(email: 'lakshmi@ait.asia', password: 'lakshman@team6', password_confirmation: 'lakshman@team6') if Rails.env.development?

