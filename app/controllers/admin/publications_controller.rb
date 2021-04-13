module Admin
  class PublicationsController < BaseController
    before_action :set_article, only: %i[create destroy]

    def create
      @article.publish!
      redirect_to %i[admin articles], notice: t('.success')
    end

    def destroy
      @article.unpublish!
      redirect_to %i[admin articles], notice: t('.success')
    end

    private

    def set_article
      @article = Article.find(params[:article_id])
    end

    def skip_pundit?
      current_user&.super_admin?
    end
  end
end
