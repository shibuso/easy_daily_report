# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.where(user_type: Settings.user_types.admin).blank?
  User.create(
          name: 'デフォルト管理者',
          email: 'admin@example.com',
          password: 'admin123',
          password_confirmation: 'admin123',
          user_type: Settings.user_types.admin
  )
end
