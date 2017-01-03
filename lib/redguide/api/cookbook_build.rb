require 'redguide/api/client'

module Redguide
  module API
    class CookbookBuild < Client
      attr_reader :name
      def initialize(project, changeset, name, cookbook)
        @project = project
        @changeset = changeset
        @cookbook = cookbook
        @name = name
      end

      def status(what=nil)
        what ? @cookbook["#{what}_status"] : @cookbook['status']
      end

      def commit_sha
        @cookbook['commit_sha']
      end

      def vcs_url
        @cookbook['vcs_url']
      end

      def remote_branch
        @cookbook['remote_branch']
      end

    end
  end
end