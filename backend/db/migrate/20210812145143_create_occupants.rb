class CreateOccupants < ActiveRecord::Migration[5.2]
  def change
    create_table :occupants do |t|
      t.string :name
      t.date :lease_end
      t.integer :apartment_id
      t.integer :tenement_id
    end
  end
end
