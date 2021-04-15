require "rails_helper"

describe ArticlesController, type: :routing do
  it { is_expected.to route(:get, "/my-awesome-page").to(action: :show, slug: "my-awesome-page") }

  context "when the slug is the same than a predefined route" do
    it { is_expected.not_to route(:get, "/mentions_legales").to(action: :show, slug: "my-awesome-page") }
    it { is_expected.to route(:get, "/mentions_legales").to(controller: :pages, action: :mentions_legales) }
  end
end
