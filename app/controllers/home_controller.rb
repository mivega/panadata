class HomeController < ApplicationController

  def index
    @compras_chart = licitation_chart_data(Licitation.where('fecha > ?', 3.month.ago))
    @compras = Rails.cache.fetch("compras_count", :expires_in => 1.hour ) { Licitation.count }
    @sociedades = Rails.cache.fetch("corporations_count", :expires_in => 1.hour ) { Corporation.count }
    @marcas = Rails.cache.fetch("brands", :expires_in => 1.hour ) { Brand.count }
    @docs = Rails.cache.fetch("contraloria_docs_count", :expires_in => 1.hour ) { ContraloriaDoc.count }
  end

  def about
    @compras = Rails.cache.fetch("compras_count", :expires_in => 1.hour ) { Licitation.count }
    @sociedades = Rails.cache.fetch("corporations_count", :expires_in => 1.hour ) { Corporation.count }
    @marcas = Rails.cache.fetch("brands", :expires_in => 1.hour ) { Brand.count }
    @docs = Rails.cache.fetch("contraloria_docs_count", :expires_in => 1.hour ) { ContraloriaDoc.count }
  end
  def stats 
  end

  private
  def licitation_chart_data(compras)
      require 'date'
      (compras.select('fecha::date as fecha_, sum(precio) as precio_').group('fecha_').order('fecha_')).map do |l|
        [ "new Date(" + (l.fecha_.to_time.utc.to_i * 1000).to_s +  ")" , "{v: " + l.precio_.to_s + ", f: '$" + l.precio_.to_s + "'}" ]
      end
  end

        
end
