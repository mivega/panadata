module LicitationsHelper
    def licitation_path(licitation)
        "/licitations/#{licitation.acto}"
    end

    def search_entidad_path(entidad)
        "/licitations/?entidad=#{CGI::escape(entidad)}"
    end

    def search_proponente_path(proponente)
        "/licitations/?proponente=#{CGI::escape(proponente)}"
    end

    def search_fecha_path(fecha)
        "/licitations/?fecha_min=#{CGI::escape(fecha.strftime('%d/%m/%Y'))}&fecha_max=#{CGI::escape(fecha.strftime('%d/%m/%Y'))}"
    end

end
