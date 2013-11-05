class Asociation < ActiveRecord::Base
    self.table_name = 'asociaciones'
    belongs_to :persona, foreign_key: 'persona_id'
    belongs_to :corporation, foreign_key: 'sociedad_id'
end
