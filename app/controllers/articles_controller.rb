class ArticlesController < ApplicationController
  def show
    @article = Article.find_by!(slug: params[:slug])
  end

  private

  def skip_pundit?
    true
  end
end
