require 'redguide/supermarket'
require 'redguide/supermarket/client'

module Redguide
  module Supermarket
    class Cookbook < Client
      attr_reader :name
      attr_reader :versions
      attr_reader :maintainer
      attr_reader :description

      def initialize(name, description = nil, versions = nil, maintainer = nil)
        @name = name
        @versions = versions
        @description = description
        @maintainer = maintainer
      end

      def url(version = nil)
        u = File.join(Redguide::Supermarket::server, 'cookbooks', @name)
        u = File.join(u, 'versions', version) if version
        u
      end

      def api_url(version = nil)
        u = File.join(Redguide::Supermarket::server, '/api/v1/', 'cookbooks', @name)
        u = File.join(u, 'versions', version) if version
        u
      end
    end
  end
end