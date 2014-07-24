require 'firebase'
require 'randomuser'
require 'net/http'
require 'net/https'
require 'json'

base_uri = 'https://rz4ie0tycxd.firebaseio-demo.com/users'

firebase = Firebase::Client.new(base_uri)

def load_users( filename )
  File.open( filename, "r" ) do |f|
    JSON.load( f )
  end
end

users = load_users("users.json")

i = 1
users.each do |user|
  firebase.set("#{i}", user)
  break if i == 50
  i += 1
end
