class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.boolean :vote
    	t.references :voteable, polymorphic: true
    	t.integer :user_id

    	t.timestamps
    end
  end
end
