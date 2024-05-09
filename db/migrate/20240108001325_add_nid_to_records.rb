class AddNidToRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :records, :nid, :string
  end
end
