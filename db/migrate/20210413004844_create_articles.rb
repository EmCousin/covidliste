class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.references :author, foreign_key: { to_table: :users }
      t.string :slug, null: false
      t.string :title, null: false
      t.string :meta_title
      t.text :description
      t.text :meta_description
      t.string :meta_keywords
      t.string :meta_robots
      t.datetime :published_at, index: true

      t.timestamps
    end
  end
end
