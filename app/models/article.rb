class Article < ApplicationRecord
  belongs_to :author, class_name: "User"

  validates :author, inclusion: {in: User.with_role(:super_admin)}
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  has_rich_text :content
end
