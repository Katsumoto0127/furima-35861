class PurchasesAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "ハイフン(-)はいりません"}
    validates :telephone_number, numericality: {only_integer: true, message: "が無効です"}
    validates :prefecture_id, numericality: {other_than: 1, message: "空白にはできません"}
    validates :city
    validates :house_number
    validates :token
  end

    validates :telephone_number, length: { minimum: 10, maximum: 11 }


  def save
    purchases = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create!(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, purchase_id: purchases.id, telephone_number: telephone_number)
  end

end