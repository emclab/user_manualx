class CreateUserManualxManuals < ActiveRecord::Migration
  def change
    create_table :user_manualx_manuals do |t|
      t.string :subject
      t.text :content
      t.integer :category_id
      t.integer :sub_category_id
      t.integer :last_updated_by_id
      t.integer :submited_by_id

      t.timestamps
    end
    
    add_index :user_manualx_manuals, :subject
    add_index :user_manualx_manuals, :category_id
    add_index :user_manualx_manuals, :sub_category_id
  end
end
