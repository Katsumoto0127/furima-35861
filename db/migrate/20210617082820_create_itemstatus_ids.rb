class CreateItemstatusIds < ActiveRecord::Migration[6.0]
  def change
    create_table :itemstatus_ids do |t|

      t.timestamps
    end
  end
end
