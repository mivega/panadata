class Product < ActiveRecord::Base
    self.table_name = 'productos'
    belongs_to :brand, foreign_key: 'marca_id'
end
