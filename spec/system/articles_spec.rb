require "rails_helper"

shared_examples "A not found page" do |slug|
  before do
    visit article_path(slug)

    it { is_expected.to have_current_path("/a-slug-for-an-non-existing-article") }
    it { is_expected.to have_text(I18n.t("articles.not_found.title")) }
    it { is_expected.to have_text(I18n.t("articles.not_found.headline")) }
    it { is_expected.to have_text(I18n.t("articles.not_found.back")) }
  end
end

describe "Articles", type: :system do
  subject { page }

  let(:article) { create :article, :published }

  before { visit article_path(article.slug) }

  it { is_expected.to have_current_path(article_path(article.slug)) }
  it { is_expected.to have_text(article.title) }
  it { is_expected.to have_text(article.content.body.to_html) }
  it { is_expected.not_to have_text(I18n.t("system_buttons.edit")) }

  context "when tthe visitor is an authenticated super admin" do
    let(:user) { create(:user, :super_admin) }

    before { login_as(user) }

    it { is_expected.not_to have_text(I18n.t("system_buttons.edit")) }
  end

  context "when the article does not exist" do
    it_behaves_like "A not found page", "/a-slug-for-an-non-existing-article"
  end

  context "when the article is not published" do
    it_behaves_like "A not found page", FactoryBot.create(:article).slug
  end
end
