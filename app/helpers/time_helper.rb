module TimeHelper
  def format_time(t)
    formatted = t.strftime("%H:%M") + " "
    unless t.today?
      unless t.this_year?
        formatted << t.strftime("%Y-%m-%d")
      else
        formatted << t.strftime("%m-%d")
      end
    end

    formatted
  end
end

