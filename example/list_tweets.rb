require 'alt_tw'

t = AltTwitter::Twitter.new
tweets = t.user_timeline('elonmusk')
puts tweets.select{|t| t.text =~ /mars|space|dragon/i }.collect{|t| t.text }
