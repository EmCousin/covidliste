require "rails_helper"

describe Article, type: :model do
  subject { build :article }
  before { create :user, :super_admin }

  it_behaves_like "a Publishable resource"

  describe "relations" do
    it { is_expected.to belong_to(:author).class_name("User") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug) }
  end
end

