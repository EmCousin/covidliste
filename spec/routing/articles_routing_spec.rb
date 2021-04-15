require "rails_helper"

describe ArticlesController, type: :routing do
  it { is_expected.to route(:post, "/my-awesome-page").to(action: :show, slug: "my-awesome-page") }
end
