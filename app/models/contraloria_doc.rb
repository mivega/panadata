class ContraloriaDoc < ActiveRecord::Base
    self.table_name = 'documentos'

    include PgSearch
    pg_search_scope :search, against: {institucion: 'A', favor: 'B', documento: 'C'},
    using: {
      tsearch: { tsvector_column: 'tsv_nombre', :dictionary => "spanish"},
    },
    ignoring: :accents

    def self.text_search(query)
        if query.present?
	          select('control,numero,documento,institucion,favor,monto,fecha').where("tsv_nombre @@ plainto_tsquery('pg_catalog.spanish',:q)" , q: query)
        else
            select('control,numero,documento,institucion,favor,monto,fecha')
        end
    end

    def full_url
        "http://www.contraloria.gob.pa/Sicowebconsultas/tramite.aspx?control=" + self.control
    end


end
