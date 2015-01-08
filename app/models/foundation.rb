class Foundation < ActiveRecord::Base
	self.table_name = 'fundaciones'
    has_many :asociations, foreign_key: 'fundacion_id'
    has_many :personas, through: :asociations

    include PgSearch
    pg_search_scope :search, against: {nombre: 'A', ficha: 'B', agente: 'C', notaria: 'D'},
    using: {
      tsearch: { tsvector_column: 'tsv_nombre', :dictionary => "spanish"},
    },
    ignoring: :accents

    def self.text_search(query)
        if query.present?
            select('nombre,ficha,agente,notaria,fecha_registro,status').where("tsv_nombre @@ plainto_tsquery('pg_catalog.spanish',:q)" , q: query)
        else
           Foundation.select('nombre,ficha,agente,notaria,fecha_registro,status').order('fecha_registro DESC')
        end
    end

    def roles(persona_id)
        self.asociations.select{ |a| a.persona_id.to_i == persona_id.to_i }.collect{ |a| a.rol }
    end
end
