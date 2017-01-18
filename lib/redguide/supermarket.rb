require 'redguide/supermarket/cookbook'
require 'redguide/supermarket/client'

module Redguide
  module Supermarket
    @@server = nil

    def self.server
      @@server
    end

    def self.server=(val)
      @@server = val
    end

    def self.endpoint
      File.join @@server, '/api/v1'
    end
  end
end