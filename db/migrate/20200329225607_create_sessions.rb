class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :sessions, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.boolean :verified, null: false
      t.json :proof, null: false

      t.timestamps
    end
    add_index :sessions, :verified
  end
end
