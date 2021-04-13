# frozen_string_literal: true

require "rails_helper"

shared_examples "a Publishable resource" do
  subject { model }

  let(:model) { create(described_class.to_s.underscore.to_sym) }

  it { is_expected.to have_db_column(:published_at).of_type(:datetime) }

  describe "scopes" do
    describe ".published" do
      subject { model.class.published.to_sql }

      it { is_expected.to eq model.class.where.not(published_at: nil).to_sql }
    end
  end

  describe "#published?" do
    subject { model.published? }

    before { model.published_at = Time.current }

    it { is_expected.to be true }

    context "when the publication date is nil" do
      before { model.published_at = nil }

      it { is_expected.to be false }
    end
  end

  describe "#publish!" do
    subject { model.published_at? }

    before do
      model.update!(published_at: nil)
      model.publish!
    end

    it { is_expected.to be true }
  end

  describe "#unpublish!" do
    subject { model.published_at? }

    before do
      model.update!(published_at: Time.current)
      model.unpublish!
    end

    it { is_expected.to be false }
  end
end
