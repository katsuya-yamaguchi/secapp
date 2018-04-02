# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# coding: utf-8
20.times do |num|
  Video.create(video_time: "10:00:00", uq_video_name: "タイトル#{num}", uq_video_perm: "#{num}", fk_groups_id: 1)
end
