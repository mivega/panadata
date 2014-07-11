class AddSearchToContraloriaDocs < ActiveRecord::Migration

  def up
    add_column :documentos, :tsv_nombre, :tsvector
    execute "UPDATE documentos SET tsv_nombre = (setweight(to_tsvector('pg_catalog.spanish', coalesce(institucion, '')),'A') || setweight(to_tsvector(coalesce(CAST(numero as text), '0')), 'B') || setweight(to_tsvector(coalesce(CAST(control as text), '0')), 'B') || setweight(to_tsvector('pg_catalog.spanish', coalesce(favor,'')),'C') || setweight(to_tsvector('pg_catalog.spanish', coalesce(documento,'')),'D'))"

    execute "CREATE FUNCTION documentos_trigger() RETURNS trigger AS $$
            begin
              new.tsv_nombre :=
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.institucion, '')),'A') ||
                setweight(to_tsvector(coalesce(CAST(new.numero as text), '0')), 'B') || 
                setweight(to_tsvector(coalesce(CAST(new.control as text), '0')), 'B') || 
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.favor,'')),'C') ||
                setweight(to_tsvector('pg_catalog.spanish', coalesce(new.documento,'')),'D');
              return new;
            end
            $$ LANGUAGE plpgsql;"
    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON documentos FOR EACH ROW EXECUTE PROCEDURE documentos_trigger()"
    execute "create index documentos_nombre on documentos using gin(tsv_nombre)"
  end
  
  def down
    execute "drop index documentos_nombre"
    remove_column :documentos, :tsv_nombre
    execute "drop trigger tsvectorupdate on documentos"
    execute "drop function documentos_trigger()"
  end 

end
