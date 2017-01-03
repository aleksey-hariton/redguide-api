require 'redguide/api/client'
require 'redguide/api/project'
require 'redguide/api/cookbook_build'

module Redguide
  module API
    class Changeset < Client
      attr_reader :project

      def initialize(project, key, description = nil)
        @project = project
        @key = key
        @description = description
      end

      def key
        @key.upcase
      end

      def description
        @description ||= changeset['description']
      end

      def cookbook_builds
        @cookbook_builds ||= changeset['cookbooks'].map {|name, build| CookbookBuild.new(@project, self, name, build)}
      end

      def cookbook(name)
        changeset['cookbooks'][name]
      end

      def slug
        changeset['slug']
      end

      def url
        changeset['url']
      end

      def notify_cookbook(cookbook, stage, status)
        post(
            "projects/#{project.slug}/changesets/#{slug}/notify",
            :cookbook_build,
            {stage: stage, status: status, cookbook: cookbook}
        )
      end

      def add_cookbook(cookbook)
        @cookbook_builds = nil
        @changeset = post(
            "projects/#{project.slug}/changesets/#{slug}/add_cookbook",
            'cookbook', {name: cookbook}
        )
      end

      def push(to_push)
        @cookbook_builds = nil
        @changeset = post(
            "projects/#{project.slug}/changesets/#{slug}/push",
            'cookbooks',
            to_push
        )
      end




      private
      def changeset
        @changeset ||= get("projects/#{@project.key}/changesets/#{key}")
      end
    end
  end
end