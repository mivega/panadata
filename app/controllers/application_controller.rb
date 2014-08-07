class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "DESC"  
  end  

  def licitation_chart_data(compras = @licitations)
      require 'date'
      (compras.only(:where).select('extract(mon from fecha) as mon, extract(year from fecha) as year, sum(precio) as precio').group('year, mon').order('year, mon')).map do |l|
        [ "new Date(" + l.year.to_i.to_s + "," + l.mon.to_i.to_s + ", 1)" , "{v: " + l.precio.to_s + ", f: '$" + l.precio.to_s + "'}" ]
      end
  end


end
