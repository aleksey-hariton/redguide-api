require 'rest-client'

module Redguide
  module API
    class Client

      def initialize
      end

      def projects
        projects = []
        get('projects/').each do |p|
          projects << Project.new(p['key'], p['description'])
        end
        projects
      end

      def project(key)
        Project.new(key)
      end

      protected

      def get(path)
        begin
          get = connection[path].get
        rescue RestClient::Unauthorized
          relogin
          get = connection[path].get
        end
        JSON.parse(get.body)
      rescue RestClient::ExceptionWithResponse => e
        abort "ERROR: #{e.response}"
      rescue RestClient::Exception => e
        abort "ERROR: something went wrong: #{e.message}"
      end

      def post(path, what, options)
        begin
          post = connection[path].post({what => options })
        rescue RestClient::Unauthorized
          relogin
          post = connection[path].post({what => options })
        end
        JSON.parse(post.body)
      rescue RestClient::ExceptionWithResponse => e
        abort "ERROR: #{e.response}"
      rescue RestClient::Exception => e
        abort "ERROR: something went wrong: #{e.message}"
      end

      private

      def connection
        @connection ||= login
      end

      def relogin
        @connection = nil
        login
      end

      def login
        url = "#{Redguide::API::server}/api/v1/"
        api = RestClient::Resource.new(url)

        login = api['auth/sign_in'].post(
            {
                email: Redguide::API::uid,
                password: Redguide::API::password
            }
        )

        headers = {
            'access-token' => login.headers[:access_token],
            'client' => login.headers[:client],
            'uid'=> Redguide::API::uid
        }

        RestClient::Resource.new(url, headers: headers)
      end
    end
  end
end
