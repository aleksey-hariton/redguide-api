require 'redguide/api/project'

module Redguide
  module API
    STATUS_CANCELLED = -2
    STATUS_NOK = -1
    STATUS_UNKNOWN = 0
    STATUS_OK = 1
    STATUS_IN_PROGRESS = 2
    STATUS_SKIPPED = 3
    STATUS_SCHEDULED = 4
    STATUS_NOT_STARTED = 5

    STATUS_MSG = {
        STATUS_CANCELLED    => 'Cancelled',
        STATUS_NOK          => 'Failed',
        STATUS_UNKNOWN      => 'Unknown',
        STATUS_OK           => 'Success',
        STATUS_IN_PROGRESS  => 'In Progress',
        STATUS_SKIPPED      => 'Skipped',
        STATUS_SCHEDULED    => 'Scheduled',
        STATUS_NOT_STARTED  => 'No Started',
    }

    @@server = nil
    @@uid = nil
    @@password = nil

    def self.server
      @@server
    end

    def self.server=(val)
      @@server = val
    end


    def self.uid
      @@uid
    end

    def self.uid=(val)
      @@uid = val
    end

    def self.password=(val)
      @@password = val
    end

    def self.password
      @@password
    end

  end
end
