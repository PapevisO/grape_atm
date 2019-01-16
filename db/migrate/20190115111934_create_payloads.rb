class CreatePayloads < ActiveRecord::Migration[5.2]
  def change
    create_table :payloads do |t|
      t.integer :nominal
      t.integer :number
    end
  end
end
