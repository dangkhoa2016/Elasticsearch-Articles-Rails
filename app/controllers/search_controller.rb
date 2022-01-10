class SearchController < ApplicationController
  def index
    options = {
      category:       params[:c],
      author:         params[:a],
      published_week: params[:w],
      published_day:  params[:d],
      sort:           params[:s],
      comments:       params[:comments],
      type:           params[:t]
    }

    @search_params = params.permit(:q, :a, :c, :s, :w, :comments, :t)

    @articles = Article.search(params[:q], options).page(page_index).per(page_size).results
  end

  private

  def page_index
    [params[:page].to_i, 1].max    
  end

  def page_size
    [params[:per_page].to_i, 10].max    
  end
end

