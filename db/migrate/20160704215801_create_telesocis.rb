class CreateTelesocis < ActiveRecord::Migration[5.0]
  def change
    create_table :telesocis do |t|
      t.string :phone
      t.references :associations, foreign_key: true

      t.timestamps
    end
  end
end
