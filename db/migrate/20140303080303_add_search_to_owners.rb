class AddSearchToOwners < ActiveRecord::Migration

  def up
    add_column :titulares, :tsv_nombre, :tsvector
    execute "UPDATE titulares SET tsv_nombre = (setweight(to_tsvector('pg_catalog.spanish', coalesce(nombre, '')),'A') || setweight(to_tsvector('pg_catalog.spanish', coalesce(domicilio,'')),'B') || setweight(to_tsvector('pg_catalog.spanish', coalesce(pais,'')),'c') || setweight(to_tsvector('pg_catalog.spanish', coalesce(estado,'')),'D'))"

    execute "CREATE FUNCTION titulares_trigger() RETURNS trigger AS $$
            begin
              new.tsv_nombre :=
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.nombre, '')),'A') ||
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.domicilio, '')),'B') ||
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.pais, '')),'C') ||
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.estado,'')),'D');
              return new;
            end
            $$ LANGUAGE plpgsql;"
    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON titulares FOR EACH ROW EXECUTE PROCEDURE titulares_trigger()"
    execute "create index titulares_nombre on titulares using gin(tsv_nombre)"
  end
  
  def down
    execute "drop index titulares_nombre"
    remove_column :titulares, :tsv_nombre
    execute "drop trigger tsvectorupdate on titulares"
    execute "drop function titulares_trigger()"
  end 


end
