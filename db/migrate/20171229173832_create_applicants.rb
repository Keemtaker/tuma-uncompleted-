class CreateApplicants < ActiveRecord::Migration[5.1]
  def change
    create_table :applicants do |t|
      t.string :first_name
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end
