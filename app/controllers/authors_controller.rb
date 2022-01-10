class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  before_action :set_page_size, only: [:index, :list, :show, :writers, :search]

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.page(page_index).per(page_size)
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
    @articles = @author.articles.page(page_index).per(page_size)
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def writers
    index
  end

  # GET /authors/search
  def search
    keyword = params[:q].to_s
    if keyword.length == 0
      return redirect_to action: :index
    end

    if keyword.length > 1
      # @authors = Author.where("first_name + ' ' + last_name LIKE ?", "%" + keyword + "%").page(page_index).per(page_size)
      @authors = Author.where("first_name LIKE ? OR last_name LIKE ?", "%#{keyword}%", "%#{keyword}%") .page(page_index).per(page_size)
    else
      @msg = 'Please enter more than 1 letter.'
    end
    render action: :index
  end

  private

  def set_page_size
    @page_size = if params[:action] == 'list'
      6
    elsif params[:action] == 'writers'
      12
    else
      10
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_author
    @author = Author.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def author_params
    params.require(:author).permit(:first_name, :last_name)
  end

  def page_index
    [params[:page].to_i, 1].max    
  end

  def page_size
    [params[:per_page].to_i, @page_size].max    
  end
end
