class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :cotent, :null => false

      t.timestamps
      
      t.references :users
      t.references :articles, :null => false
    end
    add_foreign_key(:comments,
                    :users,
                    :dependent => :delete_all,
                    :column => 'users_id',
                    :name => 'fk_comments_users')
    add_foreign_key(:comments,
                    :articles,
                    :dependent => :delete_all,
                    :column => 'articles_id',
                    :name => 'fk_comments_articles')

  end
end
