class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :users, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :username, null: false
      t.string :salt, null: false
      t.string :verifier, null: false
      t.json :proof, null: true

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
