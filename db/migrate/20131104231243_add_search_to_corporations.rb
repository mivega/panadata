class AddSearchToCorporations < ActiveRecord::Migration

  def up
    add_column :sociedades, :tsv_nombre, :tsvector
    execute "UPDATE sociedades SET tsv_nombre = (setweight(to_tsvector('pg_catalog.spanish', coalesce(nombre, '')),'A') || setweight(to_tsvector(coalesce(CAST(ficha as text), '0')), 'B') || setweight(to_tsvector('pg_catalog.spanish', coalesce(agente,'')),'C') || setweight(to_tsvector('pg_catalog.spanish',coalesce(notaria,'')),'D'))"

    execute "CREATE FUNCTION sociedades_trigger() RETURNS trigger AS $$
            begin
              new.tsv :=
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.nombre, '')),'A') ||
                setweight(to_tsvector(coalesce(CAST(new.ficha as text), '0')), 'B') || 
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.agente,'')),'C') || 
                setweight(to_tsvector('pg_catalog.spanish',coalesce(new.notaria,'')),'D');
              return new;
            end
            $$ LANGUAGE plpgsql;"
    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON sociedades FOR EACH ROW EXECUTE PROCEDURE sociedades_trigger()"
    execute "create index sociedades_nombre on sociedades using gin(tsv_nombre)"
  end
  
  def down
    remove_column :sociedades, :tsv_nombre
    execute "drop index sociedades_nombre"
    execute "drop trigger tsvectorupdate on sociedades"
  end 

end
