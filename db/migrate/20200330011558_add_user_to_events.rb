class AddUserToEvents < ActiveRecord::Migration[6.0]
  def change
    add_reference :events, :user, null: false, foreign_key: true, type: :uuid
  end
end
