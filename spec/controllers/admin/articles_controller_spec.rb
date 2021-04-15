require "rails_helper"

describe Admin::ArticlesController, type: :controller do
  render_views

  let(:user) { create(:user, :super_admin) }
  let!(:article) { create :article }

  before { sign_in user }

  describe "#index" do
    subject { get :index }

    it { is_expected.to have_http_status :ok }
    it { is_expected.to render_template "admin/articles/index" }
  end

  describe "#show" do
    subject { get :show, params: {id: article.id} }

    it { is_expected.to have_http_status :ok }
    it { is_expected.to render_template "admin/articles/show" }

    context "when the article does not exist" do
      subject { get :show, params: {id: "wrong_id"} }

      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe "#new" do
    subject { get :new }

    it { is_expected.to have_http_status :ok }
    it { is_expected.to render_template "admin/articles/new" }
  end

  describe "#create" do
    subject { post :create, params: article_params }

    let(:article_params) do
      {article: attributes_for(:article)}
    end

    it { expect { subject }.to change(Article, :count).by 1 }
    it { is_expected.to redirect_to admin_article_url(Article.last) }

    context "when mandatory params are missing" do
      let(:article_params) do
        {article: {meta_robots: "the slug is missing"}}
      end

      it { is_expected.to have_http_status :unprocessable_entity }
      it { is_expected.to render_template("admin/articles/new") }
      it { expect { subject }.not_to change(Article, :count) }
    end
  end

  describe "#edit" do
    subject { get :edit, params: {id: article.id} }

    it { is_expected.to have_http_status :ok }
    it { is_expected.to render_template "admin/articles/edit" }

    context "when the article does not exist" do
      subject { get :edit, params: {id: "wrong_id"} }

      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe "#update" do
    subject { put :update, params: article_params }

    let(:article_params) do
      {
        id: article.id,
        article: {description: "A new description"}
      }
    end

    it "updates the article" do
      subject
      expect(article.reload.description).to eq "A new description"
    end
    it { is_expected.to redirect_to admin_article_url(article) }

    context "when mandatory params are missing" do
      let(:article_params) do
        {
          id: article.id,
          article: {slug: ""}
        }
      end

      it { is_expected.to have_http_status :unprocessable_entity }
      it { is_expected.to render_template("admin/articles/edit") }
    end

    context "when the article does not exist" do
      subject { put :update, params: {id: "wrong_id"} }

      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe "#destroy" do
    subject { delete :destroy, params: {id: article.id} }

    it { is_expected.to redirect_to admin_articles_url }
    it { expect { subject }.to change(Article, :count).by(-1) }

    context "when the article does not exist" do
      subject { delete :destroy, params: {id: "wrong_id"} }

      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end
