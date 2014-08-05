class Licitation < ActiveRecord::Base
    self.table_name = 'compras'
    self.primary_key = 'acto'
    belongs_to :category
    belongs_to :provider, foreign_key: 'proveedor_id', counter_cache: true
#    belongs_to :entidad, foreign_key: 'entidad_id', counter_cache: true
    default_scope { where('parsed = true and fecha is not null') }

    include PgSearch
    pg_search_scope :search, against: [:description, :proponente],
    using: {
      tsearch: { tsvector_column: 'tsv_description', :dictionary => "spanish"},
    },
    ignoring: :accents
          
    def self.text_search(query)
        if query.present?
	        where("tsv_description @@ plainto_tsquery('pg_catalog.spanish',:q)" , q: query)
	      else
	        all
        end
    end

    def full_url
        "http://panamacompra.gob.pa/AmbientePublico/" + self.url
    end

     


end
