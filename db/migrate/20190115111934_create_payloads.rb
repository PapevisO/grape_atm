class CreatePayloads < ActiveRecord::Migration[5.2]
  def change
    create_table :payloads do |t|
      t.integer :denomination
      t.integer :quantity
    end
  end
end
