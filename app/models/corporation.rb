class Corporation < ActiveRecord::Base
    self.table_name = 'sociedades'
    has_many :asociations, foreign_key: 'sociedad_id'
    has_many :personas, through: :asociations

    include PgSearch
    pg_search_scope :search, against: {nombre: 'A', ficha: 'B', agente: 'C', notaria: 'D'},
    using: {
      tsearch: { tsvector_column: 'tsv_nombre', :dictionary => "spanish"},
    },
    ignoring: :accents

    def self.text_search(query)
        if query.present?
            search(query)
        else
           Corporation.all 
        end
    end

    def roles(persona_id)
        self.asociations.select{ |a| a.persona_id.to_i == persona_id.to_i }.collect{ |a| a.rol }
    end

end
