require 'firebase'
require 'randomuser'
require 'net/http'
require 'net/https'
require 'json'

base_uri = 'https://rz4ie0tycxd.firebaseio-demo.com/'

firebase = Firebase::Client.new(base_uri)

def load_users( filename )
  File.open( filename, "r" ) do |f|
    JSON.load( f )
  end
end

users = load_users("users.json")

while true

  users.shuffle!

  updated_users = {}
  i = 1
  users.each do |user|
    user["rank"] = i
    updated_users[i.to_s] = user
    break if i == 50
    i += 1
  end

  response = firebase.update("users", updated_users)

  sleep 2
end

#firebase_users = firebase.get("users")
#firebase.update("users", { "1" => users[0] })
