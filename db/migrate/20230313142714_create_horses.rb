class CreateHorses < ActiveRecord::Migration[7.0]
  def change
    create_table :horses do |t|
      t.string :name
      t.string :colour
      t.string :breed
      t.string :location
      t.integer :height
      t.text :description
      t.string :discipline
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
