class Importacion < ActiveRecord::Base
    self.table_name = 'importaciones'

    def self.text_search(query)
        if query.present?
	    where("tsv_nombre @@ plainto_tsquery('pg_catalog.spanish',:q)" , q: query)
        else
            where('fecha is not null')
        end
    end

end
