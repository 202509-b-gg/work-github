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
   {name: "モンブラン", introduction: "熊本県産の和栗を贅沢に使用した濃厚なモンブランです。", price: 480, genre: genres[0], is_active: true },
  {name: "ガトーショコラ", introduction: "フランス産カカオを使用したしっとり濃厚なチョコレートケーキです。", price: 420, genre: genres[0], is_active: true },
  {name: "レアチーズケーキ", introduction: "爽やかな酸味が特徴の北海道産クリームチーズを使用しています。", price: 400, genre: genres[0], is_active: true },
  {name: "フルーツタルト", introduction: "旬のフルーツをふんだんに盛りつけた華やかなタルトです。", price: 550, genre: genres[0], is_active: true },
  {name: "抹茶ロールケーキ", introduction: "京都宇治産の抹茶を使用した香り高いロールケーキです。", price: 380, genre: genres[0], is_active: true },
  {name: "バスクチーズケーキ", introduction: "表面を香ばしく焼き上げた濃厚でクリーミーなバスクチーズケーキです。", price: 450, genre: genres[0], is_active: true },
  {name: "ミルクレープ", introduction: "薄く焼いたクレープとカスタードを重ねた優しい甘さのケーキです。", price: 430, genre: genres[0], is_active: true },
  {name: "シュークリーム", introduction: "カリッと焼き上げた生地に自家製カスタードをたっぷり詰めました。", price: 220, genre: genres[0], is_active: true },
  {name: "苺ロールケーキ", introduction: "ふわふわの生地で生クリームと苺を包み込んだ人気のロールケーキです。", price: 390, genre: genres[0], is_active: true },
  {name: "ティラミス", introduction: "マスカルポーネチーズとコーヒーの風味が絶妙なイタリアの定番デザートです。", price: 420, genre: genres[0], is_active: true }
  ]
)
