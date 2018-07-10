class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :token
      t.integer :request_count, default: 0

      t.timestamps
    end

    add_index :users, :token, unique: true
  end
end
