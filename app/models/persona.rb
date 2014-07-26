class Persona < ActiveRecord::Base
    has_many :asociations
    has_many :corporations, through: :asociations

    include PgSearch
    pg_search_scope :search, against: [:nombre],
    using: {
      tsearch: { tsvector_column: 'tsv_nombre', :dictionary => "spanish"},
    },
    ignoring: :accents

    def self.text_search(query)
        if query.present?
            search(query)
        else
           Persona.all 
        end
    end

    def roles(corp_id)
        self.asociations.select{ |a| a.sociedad_id.to_i == corp_id.to_i }.collect{ |a| a.rol }
    end

end
