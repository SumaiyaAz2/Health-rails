class RemoveNidFromRecordBlock < ActiveRecord::Migration[7.1]
  def change
    remove_column :record_blocks, :nid, :string
  end
end
