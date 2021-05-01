class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone
      t.datetime :birthday

      t.timestamps
    end
  end
end
