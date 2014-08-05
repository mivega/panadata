class Entidad < ActiveRecord::Base
    self.table_name = 'entidades'
    default_scope { where('nombre is not null').order('nombre') }

    has_many :licitations, foreign_key: 'entidad_id'

    def self.text_search(query)
        if query.present?
            select('entidades.id,entidades.nombre').where("to_tsvector('pg_catalog.spanish',coalesce(unaccent(nombre),'')) @@ plainto_tsquery('pg_catalog.spanish',unaccent(:q))" , q: query)
        else
            select('entidades.id,entidades.nombre')
        end
    end

end
