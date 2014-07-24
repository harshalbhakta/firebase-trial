# This file will generate users with below fields from random_users.json.
# email, name, id, picture, profile_url, points, rank and username.

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

random_users = load_users("random_users.json")

users = []
i = 1
random_users.each do |user|
  random_user = user["user"]

  user = {}
  user["email"] = random_user["email"]
  user["name"] = (random_user["name"]["first"].capitalize + " " + random_user["name"]["last"].capitalize)
  user["id"] = i
  user["picture"] = random_user["picture"]
  user["profile_url"] = random_user["picture"]
  user["points"] = i * 100
  user["rank"] = i
  user["username"] = random_user["username"]

  users.push user
  i += 1
end

File.open("users.json","w") do |f|
  f.write(JSON.pretty_generate(users))
end
