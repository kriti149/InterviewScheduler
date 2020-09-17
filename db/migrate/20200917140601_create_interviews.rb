class CreateInterviews < ActiveRecord::Migration[6.0]
  def change
    create_table :interviews do |t|
      t.string :role
      t.date :interview_date
      t.time :start_time
      t.time :end_time

      t.references :interviewer, references: :users, foreign_key: { to_table: :users}, null: false
      t.references :candidate, references: :users, foreign_key: { to_table: :users}, null: false

      t.timestamps
    end
  end
end
