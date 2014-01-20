module ApplicationHelper

  def export_licitations_path
    'http://ec2-54-226-154-24.compute-1.amazonaws.com/licitaciones.csv'
  end

  def export_corporations_path
    'http://ec2-54-226-154-24.compute-1.amazonaws.com/sociedades.csv'
  end

  def entidad_chart_data 
    Rails.cache.fetch("entidad_chart_data", :expires_in => 5.minutes) do
      (Licitation.sum(:precio, :group => :entidad)).map do |entidad,precio|
        [ entidad,precio.to_f ] 
      end
    end
  end
  
  def categoria_chart_data 
      (Licitation.where('compras.category_id IS NOT NULL').sum(:precio, :group => :category)).map do |category,precio|
        [ category.name,precio.to_f ]
      end
  end

  def total_por_dia_data
    Rails.cache.fetch("total_por_dia_data", :expires_in => 5.minutes) do
      (Licitation.total_by_day(4.year.ago).sort_by{|x| x.date }).map do |compra_date|
        [ 
          compra_date.date,
          compra_date.total_price.to_f
        ] 
      end.unshift(['Fecha','Precio'])
    end
  end


end
