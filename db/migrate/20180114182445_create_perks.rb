class CreatePerks < ActiveRecord::Migration[5.1]
  def change
    create_table :perks do |t|
      t.string :name

      t.timestamps
    end
  end
end
