class HomeController < ApplicationController
  def index
    @compras = Licitation.count
    @sociedades = Corporation.count
    @marcas = Brand.count
    @docs = ContraloriaDoc.count
  end
  def about
  end
  def stats 
  end
        
end
