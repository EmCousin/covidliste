module Author
  extend ActiveSupport::Concern

  included do
    has_many :articles, foreign_key: :author_id,
                        dependent: :restrict_with_error
  end
end
