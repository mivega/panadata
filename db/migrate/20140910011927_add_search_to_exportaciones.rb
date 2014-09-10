class AddSearchToExportaciones < ActiveRecord::Migration
  def up
    add_column :exportaciones, :tsv_nombre, :tsvector
    execute "UPDATE exportaciones SET tsv_nombre = (setweight(to_tsvector('pg_catalog.spanish', coalesce(empresa, '')),'A') || setweight(to_tsvector(coalesce(destino, '')), 'B') || setweight(to_tsvector('pg_catalog.spanish', coalesce(descripcion,'')),'A') || setweight(to_tsvector(coalesce(ruc,'')),'C'))"

    execute "CREATE FUNCTION exportaciones_trigger() RETURNS trigger AS $$
            begin
              new.tsv_nombre :=
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.empresa, '')),'A') ||
                setweight(to_tsvector(coalesce(new.destino, '')),'B') ||
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.descripcion, '')),'A') ||
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.ruc,'')),'C');
              return new;
            end
            $$ LANGUAGE plpgsql;"
    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON exportaciones FOR EACH ROW EXECUTE PROCEDURE exportaciones_trigger()"
    execute "create index exportaciones_nombre on exportaciones using gin(tsv_nombre)"
  end
  
  def down
    execute "drop index exportaciones_nombre"
    remove_column :exportaciones, :tsv_nombre
    execute "drop trigger tsvectorupdate on exportaciones"
    execute "drop function exportaciones_trigger()"
  end 

end
