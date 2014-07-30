class Provider < ActiveRecord::Base
    self.table_name = 'proveedores'

    has_many :licitations, foreign_key: 'proveedor_id'
          
    include PgSearch
    pg_search_scope :search, against: [:nombre],
    using: {
      tsearch: { tsvector_column: 'tsv_nombre', :dictionary => "spanish"},
    },
    ignoring: :accents


    def self.text_search(query)
        if query.present?
#          search(query)
	    where("tsv_nombre @@ plainto_tsquery('pg_catalog.spanish',:q)" , q: query)
        else
            Licitation.all
        end
    end
end
