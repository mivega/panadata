class AddSearchToPersonas < ActiveRecord::Migration
  def up
    add_column :personas, :tsv_nombre, :tsvector
    execute "UPDATE personas SET tsv_nombre = (to_tsvector('pg_catalog.spanish', coalesce(nombre, '')))"
    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON personas FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger(tsv_nombre, 'pg_catalog.spanish', nombre)"
    execute "create index personas_nombre on personas using gin(tsv_nombre)"
  end
  
  def down
    remove_column :personas, :tsv_nombre
    execute "drop index personas_nombre"
    execute "drop trigger tsvectorupdate on personas"
  end 

end
