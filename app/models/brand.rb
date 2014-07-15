class Brand < ActiveRecord::Base
    self.table_name = 'marcas'
    has_many :products, foreign_key: 'marca_id'
    has_many :owner_brands, foreign_key: 'marca_id'
    has_many :owners, through: :owner_brands

    include PgSearch
    pg_search_scope :search, against: {nombre: 'A', registro: 'B', abogado: 'C'},
    using: {
      tsearch: { tsvector_column: 'tsv_nombre', :dictionary => "spanish"},
    },
    ignoring: :accents

    def self.text_search(query)
        if query.present?
            search(query)
        else
           Brand.all 
        end
    end


end
