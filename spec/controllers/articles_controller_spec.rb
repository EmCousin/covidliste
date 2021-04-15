require "rails_helper"

describe ArticlesController, type: :controller do
  render_views

  let(:article) { create :article, :published }
  let(:slug) { article.slug }

  describe "#show" do
    before do
      get :show, params: {slug: slug}
    end

    it { is_expected.to respond_with :success }
    it { expect(assigns(:article)).to eq article }
    it { is_expected.to render_template "articles/show" }

    context "when the article does not exist" do
      let(:slug) { "a-slug-that-does-not-exist" }

      it { expect(assigns(:article)).to be nil }
      it { is_expected.to render_template "articles/not_found" }
    end

    context "when the article is not published" do
      let(:article) { create :article }

      it { expect(assigns(:article)).to be nil }
      it { is_expected.to render_template "articles/not_found" }
    end
  end
end
