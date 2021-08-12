class CreateApartments < ActiveRecord::Migration[5.2]
  def change
    create_table :apartments do |t|
      t.integer :number
      t.string :style
      t.integer :rent
      t.integer :tenement_id
    end
  end
end
