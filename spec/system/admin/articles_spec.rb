require "rails_helper"

describe "Admin articles", type: :system do
  subject { page }

  let(:user) { create(:user, :super_admin) }

  before { login_as(user) }

  describe "#index" do
    context "when the user is not a super admin" do
      let(:user) { create(:user, :admin) }

      it { expect { visit admin_articles_path }.to raise_error ActionController::RoutingError }
    end

    before { visit admin_articles_path }

    it { is_expected.to have_current_path(admin_articles_path) }
    it { is_expected.to have_text(I18n.t("admin.articles.index.add_article")) }
  end

  describe "#show" do
    let(:article) { create :article }

    context "when the user is not a super admin" do
      let(:user) { create(:user, :admin) }

      it { expect { visit admin_article_path(article) }.to raise_error ActionController::RoutingError }
    end

    before { visit admin_article_path(article) }

    it { is_expected.to have_current_path(admin_article_path(article)) }
    it { is_expected.to have_text(article.title) }
    it { is_expected.to have_text(article.content.body.to_html) }

    %w[back edit edit publish delete].each do |button_name|
      it { is_expected.to have_text(I18n.t("system_buttons.#{button_name}")) }
    end

    %w[show unpublish].each do |button_name|
      it { is_expected.not_to have_text(I18n.t("system_buttons.#{button_name}")) }
    end

    context "when the article is published" do
      let(:article) { create :article, :published }

      %w[show unpublish].each do |button_name|
        it { is_expected.to have_text(I18n.t("system_buttons.#{button_name}")) }
      end

      it { is_expected.not_to have_text(I18n.t("system_buttons.publish")) }
    end
  end

  describe "#new" do
    context "when the user is not a super admin" do
      let(:user) { create(:user, :admin) }

      it { expect { visit new_admin_article_path }.to raise_error ActionController::RoutingError }
    end

    before { visit new_admin_article_path }

    it { is_expected.to have_current_path(new_admin_article_path) }

    %i[title meta_title description meta_description meta_keywords meta_robots].each do |article_attribute|
      it { is_expected.to have_text(Article.human_attribute_name(article_attribute)) }
      it { is_expected.to have_field("article[#{article_attribute}]") }
    end

    it { is_expected.to have_text(Article.human_attribute_name(:content)) }
    it { expect(find_trix_editor("article_content")).to be_truthy }
  end

  describe "#edit" do
    let(:article) { create :article }

    context "when the user is not a super admin" do
      let(:user) { create(:user, :admin) }

      it { expect { visit edit_admin_article_path(article) }.to raise_error ActionController::RoutingError }
    end

    before { visit edit_admin_article_path(article) }

    it { is_expected.to have_current_path(edit_admin_article_path(article)) }

    %i[title meta_title description meta_description meta_keywords meta_robots].each do |article_attribute|
      it { is_expected.to have_text(Article.human_attribute_name(article_attribute)) }
      it { is_expected.to have_field("article[#{article_attribute}]", with: article.public_send(article_attribute)) }
    end

    it { is_expected.to have_text(Article.human_attribute_name(:content)) }
    it { expect(find_trix_editor("article_content")).to be_truthy }
    it { expect(find_trix_editor("article_content").value).to include article.content.body.to_html }
  end
end
