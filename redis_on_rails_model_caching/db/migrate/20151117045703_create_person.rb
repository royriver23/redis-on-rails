class CreatePerson < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :company
      t.string :email
      t.string :phone
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
    end
  end
end
