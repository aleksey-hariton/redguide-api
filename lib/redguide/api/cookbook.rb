require 'redguide/api/client'

module Redguide
  module API
    class Cookbook < Client
      attr_reader :name
      attr_reader :vcs_url
      attr_reader :project

      def initialize(project, name, vcs_url = nil)
        @project = project
        @name = name
        @vcs_url = vcs_url
      end
    end
  end
end