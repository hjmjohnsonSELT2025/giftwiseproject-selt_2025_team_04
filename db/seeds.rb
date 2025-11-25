# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create!({:email => "a@b.c", :password => "123456"})
Recipient.create!({:name => "test recipient", :user_id => User.find_by(:email => "a@b.c").id, :age => 50, :occupation => "okay", :hobbies => "okay", :likes => "music", :dislikes => "dance", :budget => 300})
Gift.create!({:name => "test gift", :description => "test gift description", :user_id => User.find_by(:email => "a@b.c").id, :price => 12.3, :recipient_id => Recipient.find_by(:name => "test recipient").id})


#events =[{:title => "Christmas", :location => "Home", :theme => "Christmas Themed", :date => "25-Dec-2025"}]

#events.each do |event|
  #  Event.create!(event)
  #end
