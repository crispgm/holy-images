module ImageHelper
  def extract_exif_value(input)
    input.split("(").at(1).split(")").at(0)
  end
end

