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
            scoped
        end
    end

end