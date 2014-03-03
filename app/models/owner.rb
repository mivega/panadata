class Owner < ActiveRecord::Base
    self.table_name = 'titulares'
    has_many :owner_brands, foreign_key: 'titular_id'
    has_many :brands, through: :owner_brands

    include PgSearch
    pg_search_scope :search, against: {nombre: 'A', domicilio: 'B', pais: 'C', estado: 'D'},
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
