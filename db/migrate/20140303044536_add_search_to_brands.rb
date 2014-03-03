class AddSearchToBrands < ActiveRecord::Migration

  def up
    add_column :marcas, :tsv_nombre, :tsvector
    execute "UPDATE marcas SET tsv_nombre = (setweight(to_tsvector('pg_catalog.spanish', coalesce(nombre, '')),'A') || setweight(to_tsvector(coalesce(CAST(registro as text), '0')), 'B') || setweight(to_tsvector('pg_catalog.spanish', coalesce(abogado,'')),'C'))"

    execute "CREATE FUNCTION marcas_trigger() RETURNS trigger AS $$
            begin
              new.tsv_nombre :=
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.nombre, '')),'A') ||
                setweight(to_tsvector(coalesce(CAST(new.registro as text), '0')), 'B') || 
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.abogado,'')),'C') || 
              return new;
            end
            $$ LANGUAGE plpgsql;"
    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON marcas FOR EACH ROW EXECUTE PROCEDURE marcas_trigger()"
    execute "create index marcas_nombre on marcas using gin(tsv_nombre)"
  end
  
  def down
    remove_column :marcas, :tsv_nombre
    execute "drop index marcas_nombre"
    execute "drop trigger tsvectorupdate on marcas"
  end 

end
