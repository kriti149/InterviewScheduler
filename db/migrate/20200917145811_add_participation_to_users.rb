class AddParticipationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :participation, :string
  end
end
