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
    @categories = Category.all
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      # カテゴリーが設定されていたら関連のテーブルを作成する
      if category_params
        ContentCategory.create(content_params)
      end
      redirect_to action: :index
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
    params.require(:content).permit(:title, :body, :is_active, :opened_at)
  end

  def category_params
    params.require(:content).permit(:category_id)
  end

  def set_content
    @content = Content.find_by(id: params[:id])
  end

  def set_category
    @categories = Category.all
  end
end
