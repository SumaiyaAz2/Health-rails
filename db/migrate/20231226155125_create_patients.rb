class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :name, null: false
      t.string :contact, null: false
      t.string :address, null: false
      t.string :nid, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
