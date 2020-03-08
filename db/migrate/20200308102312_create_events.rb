class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :events, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :title
      t.datetime :starts_at
      t.integer :duration

      t.timestamps
    end
    add_index :events, :starts_at
  end
end
