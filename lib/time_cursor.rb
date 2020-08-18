require "time_cursor/version"
require "time_cursor/base"
require "time_cursor/elements"
require "time_cursor/matcher"

module TimeCursor
  class  <<  self
    include TimeCursor::Base
  end
end

