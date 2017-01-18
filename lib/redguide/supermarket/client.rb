# https://supermarket.tipdev.com/api/v1/cookbooks/ebet
require 'rest-client'
require 'redguide/supermarket'

module Redguide
  module Supermarket
    class Client

      def initialize
      end

      def cookbooks
        cookbooks = []
        get('cookbooks/').each do |p|
          cookbooks << Cookbook.new(p['key'], p['description'])
        end
        cookbooks
      end

      def cookbook(name)
        get = connection["cookbooks/#{name}/"].get
        c = JSON.parse(get.body)
        versions = c['versions'].map{|v| File.basename(v)}
        Cookbook.new(c['name'], c['description'], versions)
      rescue RestClient::NotFound => e
        return nil
      rescue RestClient::ExceptionWithResponse => e
        abort "ERROR(#{e.class.name}): #{e.response}"
      rescue RestClient::Exception => e
        abort "ERROR(#{e.class.name}): something went wrong: #{e.message}"
      end

      protected

      def get(path)
        get = connection[path].get
        JSON.parse(get.body)
      rescue RestClient::ExceptionWithResponse => e
        abort "ERROR(#{e.class.name}): #{e.response}"
      rescue RestClient::Exception => e
        abort "ERROR(#{e.class.name}): something went wrong: #{e.message}"
      end

      def post(path, what, options)
        post = connection[path].post({what => options })
        JSON.parse(post.body)
      rescue RestClient::ExceptionWithResponse => e
        abort "ERROR(#{e.class.name}): #{e.response}"
      rescue RestClient::Exception => e
        abort "ERROR(#{e.class.name}): something went wrong: #{e.message}"
      end

      private

      def connection
        url = "#{Redguide::Supermarket::server}/api/v1/"
        @connection ||= RestClient::Resource.new(url)
      end
    end
  end
end
