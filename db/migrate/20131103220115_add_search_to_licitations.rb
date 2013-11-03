class AddSearchToLicitations < ActiveRecord::Migration

  def up
    add_column :compras, :tsv_description, :tsvector
    execute "create extension unaccent"
    execute "UPDATE compras SET tsv_description = (to_tsvector('pg_catalog.spanish', coalesce(description, '')))"
    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON compras FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger(tsv_description, 'pg_catalog.spanish', description)"
    execute "create index compras_description on compras using gin(tsv_description)"
  end
  
  def down
    remove_column :compras, :tsv_description
    execute "drop index compras_description"
    execute "drop trigger tsvectorupdate on compras"
    execute "drop extension unaccent;"
  end 

end
