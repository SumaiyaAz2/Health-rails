class CreateRecordBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :record_blocks do |t|
      t.string :hashh
      t.string :previous_hash
      t.string :nid

      t.timestamps
    end
  end
end
