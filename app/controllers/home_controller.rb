class HomeController < ApplicationController
  def index

    @compras = Rails.cache.fetch("compras_count", :expires_in => 1.day ) { Licitation.count }
    @sociedades = Rails.cache.fetch("corporations_count", :expires_in => 1.day ) { Corporation.count }
    @marcas = Rails.cache.fetch("brands", :expires_in => 1.day ) { Brand.count }
    @docs = Rails.cache.fetch("contraloria_docs_count", :expires_in => 1.day ) { ContraloriaDoc.count }
  end
  def about
  end
  def stats 
  end
        
end
