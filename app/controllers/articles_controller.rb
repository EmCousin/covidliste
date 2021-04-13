class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def show
    @article = Article.published.find_by!(slug: params[:slug])
  end

  private

  def skip_pundit?
    true
  end

  def not_found
    render :not_found
  end
end
