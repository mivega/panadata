class Licitation < ActiveRecord::Base
    self.table_name = 'compras'
    belongs_to :category
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
	    where("tsv_description @@ plainto_tsquery('pg_catalog.spanish',:q)" , q: query)
        else
            Licitation.all
        end
    end

    def full_url
        "http://panamacompra.gob.pa/AmbientePublico/" + self.url
    end

     


end
