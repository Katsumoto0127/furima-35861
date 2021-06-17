class CreatePrefectureIds < ActiveRecord::Migration[6.0]
  def change
    create_table :prefecture_ids do |t|

      t.timestamps
    end
  end
end
