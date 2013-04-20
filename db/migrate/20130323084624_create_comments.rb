class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, :null => false

      t.timestamps
      
      t.references :user
      t.references :article, :null => false
    end
    add_foreign_key(:comments,
                    :users,
                    :dependent => :delete_all,
                    :column => 'user_id',
                    :name => 'fk_comments_users')
    add_foreign_key(:comments,
                    :articles,
                    :dependent => :delete_all,
                    :column => 'article_id',
                    :name => 'fk_comments_articles')

  end
end
