class CreateCompras < ActiveRecord::Migration
  def change
    create_table :compras do |t|
      t.string :entidad
      t.decimal :precio
      t.string :proponente
      t.integer :categoria
      t.string :url
      t.datetime :fecha
      t.text :description
      t.string :acto
      t.integer :compra_id

      t.timestamps
    end
  end
end

