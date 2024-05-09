class AddRecordToRecordBlock < ActiveRecord::Migration[7.1]
  def change
    add_column :record_blocks, :record, :string
  end
end
