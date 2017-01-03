require 'redguide/api/client'
require 'redguide/api/changeset'

module Redguide
  module API
    class Project < Client
      def initialize(key, description = nil)
        @key = key
        @description = description
      end

      def description
        @description ||= project['description']
      end

      def config(app)
        project["#{app}_config"]
      end

      def changesets
        changesets = []
        get("projects/#{key}/changesets").each do |c|
          changesets << Changeset.new(self, c['key'], c['description'])
        end
        changesets
      end

      def changeset(key)
        Changeset.new(self, key)
      end

      def create_changeset(key, description)
        resp = post("projects/#{self.key}/changesets", 'changeset', {key: key, description: description})
        Changeset.new(self, resp['key'])
      end

      def slug
        project['slug']
      end

      def key
        @key.upcase
      end

      private
      def project
        @project ||= get("projects/#{key}")
      end
    end
  end
end