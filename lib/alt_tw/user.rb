require 'rf-rest-open-uri'

module AltTwitter
  class User
    def initialize(user)
      if user.is_a? Integer
        @id = user
      elsif user.is_a? String
        @screen_name = user
      elsif user.is_a? Hash
        @id = user[:id].to_i unless user[:id].nil?
        @screen_name = user[:screen_name]
      end
    end

    def get_details
      response = open("https://twitter.com/i/profiles/popup?user_id=#{@id}&wants_hovercard=true")
      # @TODO implement user details
    end
  end
end
