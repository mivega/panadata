class Licitation < ActiveRecord::Base
    self.table_name = 'compras'
    self.primary_key = 'acto'
    belongs_to :category
    belongs_to :provider, foreign_key: 'proveedor_id'
    default_scope { where('parsed = true and fecha is not null') }

    include PgSearch
    pg_search_scope :search, against: [:description, :proponente],
    using: {
      tsearch: { tsvector_column: 'tsv_description', :dictionary => "spanish"},
    },
    ignoring: :accents
          
    def self.text_search(query)
        if query.present?
#          search(query)
	    select('acto,description,entidad,proponente,proveedor_id,precio,fecha').where("tsv_description @@ plainto_tsquery('pg_catalog.spanish',:q)" , q: query)
        else
            Licitation.select('acto,description,entidad,proponente,proveedor_id,precio,fecha')
        end
    end

    def full_url
        "http://panamacompra.gob.pa/AmbientePublico/" + self.url
    end

     


end
