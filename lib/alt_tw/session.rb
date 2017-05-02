require 'watir'
require 'watir-scroll'

module AltTwitter
  class Session
    def initialize
    end

    def browser
      @browser ||= Watir::Browser.new(:chrome)
    end

    def visit(url)
      browser.goto url
    end

    def visit_and_scroll(url, scroll_time = 30)
      visit url
      start = Time.now
      while (Time.now < start + scroll_time) do
        browser.scroll.to :bottom
      end
    end

    def html
      browser.html
    end
  end
end
