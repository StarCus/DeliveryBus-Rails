class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :access_token
      t.belongs_to :user
      t.timestamps
    end
    add_index :tokens, :access_token
  end
end
