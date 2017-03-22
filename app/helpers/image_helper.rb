module ImageHelper
  def extract_exif_value(input)
    input.split("(").at(1).split(")").at(0)
  end
end

module DateAndTime
  module Calculations
    def this_year?
      year == ::Date.current.year
    end
  end
end
