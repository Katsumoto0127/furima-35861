class CreateShippingdayIds < ActiveRecord::Migration[6.0]
  def change
    create_table :shippingday_ids do |t|

      t.timestamps
    end
  end
end
