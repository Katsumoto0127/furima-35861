class CreateDeliverychargeIds < ActiveRecord::Migration[6.0]
  def change
    create_table :deliverycharge_ids do |t|

      t.timestamps
    end
  end
end
