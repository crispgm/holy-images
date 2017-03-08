class IndexController < ApplicationController
  def index
    page = params[:p].to_i || 1
    page = 1 if page <= 0
    start = (page - 1) * 10
    total = Image.count
    @images = Image.limit(10).offset(start)

    @page = {
      :total => total,
      :cur_page => page,
      :total_page => (total.to_f/10.to_f).ceil
    }
  end
end
