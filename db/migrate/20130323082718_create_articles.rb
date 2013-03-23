class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.integer :view_num, :null => false, :default => 0
      t.integer :comment_num, :null => false, :default => 0

      t.timestamps
      
      t.references :users, :null => false 
    end

    add_foreign_key(:articles,
                    :users,
                    :dependent => :delete_all,
                    :column => 'users_id',
                    :name => 'fk_articles_users')
  end
end
