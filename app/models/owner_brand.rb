class OwnerBrand < ActiveRecord::Base
    self.table_name = 'marca_titulares'
    belongs_to :owner, foreign_key: 'titular_id'
    belongs_to :brand, foreign_key: 'marca_id'
end
