#!/usr/bin/env ruby
# dev
require 'pry'

require 'json'
require 'nokogiri'

require 'alt_tw/session'
require 'alt_tw/tweet'
require 'alt_tw/user'

module AltTwitter
  class Twitter
    def session
      @session ||= Session.new
    end

    def document
      @document ||= Nokogiri::HTML(session.html)
    end

    def tweets
      @tweets ||= document.css('.tweet').collect{|t| Tweet.new(t) }
    end

    def get_tweets_from_url(url)
      session.visit_and_scroll url
      tweets
    end

    def search(query)
      url = "https://twitter.com/search?f=tweets&vertical=default&q=#{URI.escape(query)}&src=typd"
      get_tweets_from_url(url)
    end

    def user_timeline(username)
      url = "https://twitter.com/#{username}"
      get_tweets_from_url(url)
    end

    def login(username, password)
      session.visit "https://twitter.com"
      session.browser.text_field(id: "signin-email").set username
      session.browser.text_field(id: "signin-password").set password
      session.browser.form(class: 'LoginForm').button(class: 'js-submit').click
    end
  end
end
