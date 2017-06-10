class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  def index
    @contents = Content.all
  end

  def show
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    redirect_to action: :index if @content.save
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def content_params
    params.require(:content).permit(:title, :body, :is_active, :opened_at)
  end

  def set_content
    @content = Content.find_by(id: params[:id])
  end
end
