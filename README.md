A Twitter API without API keys, just scraping the web

**WARNING** When tested with new accounts Twitter detects this as automated
behaviour and **will lock your account and ask for a phone to unlock it**.
Since they already have your phone you may as well get the API keys...

## Get user timeline

```
t = AltTwitter::Twitter.new
tweets = t.user_timeline('elonmusk')
puts tweets.select{|t| t.text =~ /mars|space|dragon/i }.collect{|t| t.text }
```

## Search for tweets

```
t = AltTwitter::Twitter.new
tweets = t.search "free icecream"
```


## Login and tweet

```
t = AltTwitter::Twitter.new
t.login('username','password')
t.tweet('look mom, without api keys')

```
