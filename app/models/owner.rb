class Owner < ActiveRecord::Base
    self.table_name = 'titulares'
    has_many :owner_brands, foreign_key: 'titular_id'
    has_many :brands, through: :owner_brands
end
