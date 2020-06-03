class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.string :title
      t.string :topic
      t.boolean :private

      t.timestamps
    end
  end
end
