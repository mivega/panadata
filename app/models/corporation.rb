class Corporation < ActiveRecord::Base
    self.table_name = 'sociedades'

    include PgSearch
    pg_search_scope :search, against: {nombre: 'A', ficha: 'B', agente: 'C', notaria: 'D'}

    def self.text_search(query)
        if query.present?
            search(query)
        else
            scoped
        end
    end

end
