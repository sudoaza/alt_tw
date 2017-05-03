require 'alt_tw'

t = AltTwitter::Twitter.new
t.login('username','password')
t.tweet('look mom, without api keys')
