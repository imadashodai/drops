class ContentsController < ApplicationController
  include SessionsHelper
  before_action :login_check
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_action :set_category, only: [:new, :edit]

  def index
    @contents = Content.all
  end

  def show
  end

  def new
    @content = Content.new
    @categories = Category.where(is_active: 1)
  end

  def create
    @content = Content.new
    @content.title = params[:title]
    @content.body = params[:body]
    @content.is_active = params[:is_active]
    @content.opened_at = params[:opened_at]
    if @content.save
      # カテゴリーが設定されていたら関連のテーブルを作成する
      content_category = ContentCategory.new(content_id: @content.id, category_id: params[:category_id])
      if content_category.save
        redirect_to action: :index
      end
    end
  end

  def edit
  end

  def update
    @content.update(content_params)
  end

  def destroy
    redirect_to action: :index if @content.destroy
  end

  private
  def content_params
   params.require(:content).permit(:title, :body, :is_active, :opened_at, :category_id)
  end

  def set_content
    @content = Content.find_by(id: params[:id])
  end

  def set_category
    @categories = Category.all
  end
end
