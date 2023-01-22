class BlogsController < ApplicationController
  #27で使わない記述あり
  # before_action :set_blog, only: %i[ show edit update destroy ]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1 or /blogs/1.json
  def show
    set_blog
    @blog = Blog.find(params[:id])
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end


  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end

  

  # GET /blogs/1/edit
  def edit
    set_blog
    @blog = Blog.find(params[:id])
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end
  end


  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    set_blog
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_url(@blog), notice: "ブログを編集しました!" }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    set_blog
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "ブログを削除しました!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :content)
    end
end
