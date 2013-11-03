class Licitation < ActiveRecord::Base
    self.table_name = 'compras'

    include PgSearch
    pg_search_scope :search, against: [:description, :proponente],
    using: {
      tsearch: { tsvector_column: 'tsv_description', :dictionary => "spanish"},
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
