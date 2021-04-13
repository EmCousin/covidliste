module Admin
  class ArticlesController < BaseController
    before_action :set_article, only: %i[show edit update destroy]

    def index
      @pagy_articles, @articles = pagy(Article.includes(:author))
    end

    def show
    end

    def new
      @article = current_user.articles.new
    end

    def create
      @article = current_user.articles.new(article_params)
      if @article.save
        redirect_to [:admin, @article]
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @article.update(article_params)
        redirect_to [:admin, @article]
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article.destroy!
      redirect_to %i[admin articles]
    end

    private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :slug, :meta_title, :description, :meta_description, :meta_keywords, :meta_robots, :content)
    end

    def skip_pundit?
      current_user&.super_admin?
    end
  end
end
