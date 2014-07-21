class HomeController < ApplicationController
  def index
  end
  def about
    @compras = Rails.cache.fetch("compras_count", :expires_in => 1.hour ) { Licitation.count }
    @sociedades = Rails.cache.fetch("corporations_count", :expires_in => 1.hour ) { Corporation.count }
    @marcas = Rails.cache.fetch("brands", :expires_in => 1.hour ) { Brand.count }
    @docs = Rails.cache.fetch("contraloria_docs_count", :expires_in => 1.hour ) { ContraloriaDoc.count }
  end
  def stats 
  end
        
end
