class Licitation < ActiveRecord::Base
    self.table_name = 'compras'
    belongs_to :category
    belongs_to :provider, foreign_key: 'proveedor_id', counter_cache: true
#    belongs_to :entidad, foreign_key: 'entidad_id', counter_cache: true

    include PgSearch
    pg_search_scope :search, against: [:description, :proponente],
    using: {
      tsearch: { tsvector_column: 'tsv_description', :dictionary => "spanish"},
    },
    ignoring: :accents
          
    def self.text_search(query)
        if query.present?
	    select('acto,description,entidad,proponente,proveedor_id,precio,fecha').where("tsv_description @@ plainto_tsquery('pg_catalog.spanish',:q)" , q: query)
	  else
	    select('acto,description,entidad,proponente,proveedor_id,precio,fecha')
        end
    end

    def full_url
        "http://panamacompra.gob.pa/AmbientePublico/" + self.url
    end

     


end
