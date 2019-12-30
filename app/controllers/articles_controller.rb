class ArticlesController < ApplicationController
  def index
    opts = {}
    opts[:labels_name_or_title_cont] = params[:q] if params[:q].present?
    @articles = Article.ransack(opts).result.page(params[:page]).per(2)
    @labels = Label.where(labeled_type: 'Article').group(:name).distinct(:name)
  end

  def show
    @article = Article.find_by_id params[:id]
    @labels = Label.where(labeled_type: 'Article').group(:name).distinct(:name)
  end
end
