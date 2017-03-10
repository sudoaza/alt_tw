module AltTwitter
  class Tweet
    def initialize(tweet)
      if tweet.is_a? Nokogiri::XML::Element
        @xml = tweet
      end
    end

    def text
      @text ||= @xml.css('.content .tweet-text').text
    end

    def retweet?
      @retweet ||= !@xml.attr('data-retweet-id').nil?
    end

    def retweeter
      @retweeter ||= User.new(@xml.attr('data-retweeter')) if retweet?
    end

    def author
      @author ||= User.new({id: @xml.attr('data-user-id'), screen_name: @xml.attr('data-screen-name')})
    end

    def retweet_count
      @retweet_count ||= parse_retweet_count
    end

    def parse_retweet_count
      @xml.css('.ProfileTweet-actionButton.js-actionRetweet .ProfileTweet-actionCountForPresentation').text.to_i
    end

    def favorite_count
      @favorite_count ||= parse_favorite_count
    end

    def parse_favorite_count
      @xml.css('.ProfileTweet-actionButton.js-actionFavorite .ProfileTweet-actionCountForPresentation').text.to_i
    end

    # ALgunos bots se mandan estos RT sin arrobar correctamente al usuario
    def fail_retweet?
      (@text =~ /RT [a-z_-]+:/i) === 0
    end

    def old_retweet?
      (@text =~ /RT @[a-z_-]+:/i) === 0
    end
  end
end
