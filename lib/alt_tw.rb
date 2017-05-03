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
      session.visit 'https://twitter.com'
      show_login.click unless login_form.visible?
      if login_form.visible?
        login_field.set username
        password_field.set password
        login_button.click
      end
    end

    def login_form
      session.browser.form(class: 'LoginForm')
    end

    def show_login
      session.browser.link(class: 'StreamsLogin')
    end

    def login_field
      login_form.element(class: 'LoginForm-username').text_field(class: 'text-input')
    end

    def password_field
      login_form.element(class: 'LoginForm-password').text_field(class: 'text-input')
    end

    def login_button
      login_form.button(class: 'js-submit')
    end

    def tweet(text)
      session.browser.element(id: 'tweet-box-home-timeline').click
      session.browser.send_keys text
      session.browser.send_keys [:control, :return]
    end
  end
end
