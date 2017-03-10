#!/usr/bin/env ruby
# dev
require 'pry'
require 'rb-readline'

require 'json'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'nokogiri'

require 'alt_tw/tweet'
require 'alt_tw/user'

Capybara.default_max_wait_time = 10

options = { debug: false,
  window_size: [980, 9000],
  js_errors: false}

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist

module AltTwitter
  class Twitter
    include Capybara::DSL
    def get_page(url)
      page.driver.headers = {'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0'}
      visit(url)
      # @TODO fix scroll
      page.driver.scroll_to(1,9999)
      find('.stream-footer').send_keys(:pgdown,:down,:spacebar)
      @document = Nokogiri::HTML(page.html)
    end

    def get_tweets_from_url(url)
      get_page(url)
      @tweets = extract_tweets
    end

    def extract_tweets
      @document.css('.tweet').collect{|t| Tweet.new(t) }
    end

    def search(query)
      url = "https://twitter.com/search?f=tweets&vertical=default&q=#{URI.escape(query)}&src=typd"
      get_tweets_from_url(url)
    end

    def user_timeline(username)
      url = "https://twitter.com/#{username}"
      get_tweets_from_url(url)
    end
  end
end
