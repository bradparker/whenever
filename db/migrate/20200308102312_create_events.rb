class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :events, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :title, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false

      t.timestamps
    end
    add_index :events, :starts_at
    add_index :events, :ends_at
  end
end
