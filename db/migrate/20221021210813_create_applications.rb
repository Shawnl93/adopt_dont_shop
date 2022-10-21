class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :address
      t.string :description
      t.string :application_status
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip_code

      t.timestamps
    end
  end
end
