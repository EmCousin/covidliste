class Article < ApplicationRecord
  include Publishable

  belongs_to :author, class_name: "User"
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  has_rich_text :content
end
