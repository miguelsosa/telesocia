class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :email
      t.string :url
      t.string :notes

      t.timestamps
    end
  end
end
