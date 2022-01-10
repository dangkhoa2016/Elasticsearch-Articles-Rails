class CommentsController < ApplicationController
  before_action :set_comment, only: [:show]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.page(page_index).per(page_size)
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def page_index
      [params[:page].to_i, 1].max    
    end

    def page_size
      [params[:per_page].to_i, 10].max    
    end
end
