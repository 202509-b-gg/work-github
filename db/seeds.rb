# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Genre.destroy_all
Item.destroy_all

genres = Genre.create!([
  { name: "ケーキ" },
  { name: "焼き菓子" },
  { name: "プリン" },
  { name: "キャンディ" }
])

Item.create!(
  [
   {name: "いちごのショートケーキ（ホール）", introduction: "栃木産のとちおとめを贅沢に使用しています。", price: 2500, genre: genres[0], is_active: true },
   {name: "チョコバナナミルフィーユ", introduction: "フィリピン産のバナナを使用しています。", price: 1000, genre: genres[0], is_active: true },
   {name: "チーズタルト", introduction: "北海道産のチーズを使用しています。", price: 300, genre: genres[0], is_active: true },
  ]
)
