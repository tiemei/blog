class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps

      t.references :user
      t.references :article
    end

    add_foreign_key(:tags,
                    :users,
                    :dependent => :delete_all,
                    :column => 'user_id',
                    :name => 'fk_tags_users')
    add_foreign_key(:tags,
                    :articles,
                    :dependent => :delete_all,
                    :column => 'article_id',
                    :name => 'fk_tags_articles')
  end
end
