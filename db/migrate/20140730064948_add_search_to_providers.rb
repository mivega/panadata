class AddSearchToProviders < ActiveRecord::Migration

  def up
    add_column :proveedores, :tsv_nombre, :tsvector
    execute "UPDATE proveedores SET tsv_nombre = to_tsvector('pg_catalog.spanish', coalesce(nombre, ''))"

    execute "CREATE FUNCTION proveedores_trigger() RETURNS trigger AS $$
            begin
              new.tsv_nombre := to_tsvector('pg_catalog.spanish', coalesce(new.nombre, ''));
              return new;
            end
            $$ LANGUAGE plpgsql;"
    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON proveedores FOR EACH ROW EXECUTE PROCEDURE proveedores_trigger()"
    execute "create index proveedores_nombre on proveedores using gin(tsv_nombre)"
  end
  
  def down
    execute "drop index proveedores_nombre"
    remove_column :proveedores, :tsv_nombre
    execute "drop trigger tsvectorupdate on proveedores"
    execute "drop function proveedores_trigger()"
  end 
end
