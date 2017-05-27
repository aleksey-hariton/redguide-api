require 'redguide/api/client'

module Redguide
  module API
    class Prconfig < Client
      attr_reader :name
      attr_reader :content
      attr_reader :project

      def initialize(project, name, content = nil)
        @project = project
        @name = name
        @content = content
      end
    end
  end
end