# frozen_string_literal: true

require "rails_helper"

shared_examples "an Author" do
  subject { model }

  let(:model) { create(described_class.to_s.underscore.to_sym) }

  it { is_expected.to have_many(:articles).with_foreign_key(:author_id).dependent(:restrict_with_error) }
end
