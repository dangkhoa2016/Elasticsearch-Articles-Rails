class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_page_size, only: [:index, :list, :show, :sections, :search]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.includes(:articles).page(page_index).per(page_size)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @articles = @category.present? ? @category.articles.page(page_index).per(page_size) : []
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sections
    index
  end

  # GET /categories/search
  def search
    keyword = params[:q].to_s
    if keyword.length == 0
      return redirect_to action: :index
    end

    if keyword.length > 1
      @categories = Category.where("title LIKE ?", "%" + keyword + "%").page(page_index).per(page_size)
    else
      @msg = 'Please enter more than 1 letter.'
    end

    render action: :index
  end

  private

  def set_page_size
    @page_size = if params[:action] == 'list'
      6
    elsif params[:action] == 'sections'
      9
    else
      10
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.where(id: params[:id])&.first
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:title)
  end

  def page_index
    [params[:page].to_i, 1].max    
  end

  def page_size
    [params[:per_page].to_i, @page_size].max    
  end
end
