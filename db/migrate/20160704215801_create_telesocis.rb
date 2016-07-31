class CreateTelesocis < ActiveRecord::Migration[5.0]
  def change
    create_table :telesocis do |t|
      t.string :phone
      t.string :nickname
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :email
      t.string :url
      t.string :notes
      t.timestamps
    end
  end
end
