class AddSearchToImportaciones < ActiveRecord::Migration
  
  def up
    add_column :importaciones, :tsv_nombre, :tsvector
    execute "UPDATE importaciones SET tsv_nombre = (setweight(to_tsvector('pg_catalog.spanish', coalesce(empresa, '')),'A') || setweight(to_tsvector(coalesce(procedencia, '')), 'B') || setweight(to_tsvector('pg_catalog.spanish', coalesce(descripcion,'')),'A') || setweight(to_tsvector(coalesce(ruc,'')),'C'))"

    execute "CREATE FUNCTION importaciones_trigger() RETURNS trigger AS $$
            begin
              new.tsv_nombre :=
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.empresa, '')),'A') ||
                setweight(to_tsvector(coalesce(new.procedencia, '')),'B') ||
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.descripcion, '')),'A') ||
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.ruc,'')),'C');
              return new;
            end
            $$ LANGUAGE plpgsql;"
    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON importaciones FOR EACH ROW EXECUTE PROCEDURE importaciones_trigger()"
    execute "create index importaciones_nombre on importaciones using gin(tsv_nombre)"
  end
  
  def down
    execute "drop index importaciones_nombre"
    remove_column :importaciones, :tsv_nombre
    execute "drop trigger tsvectorupdate on importaciones"
    execute "drop function importaciones_trigger()"
  end 

end
