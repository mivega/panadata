module BrandsHelper
    def estado_label(brand)
        if brand.estado == 'Registrada'
            render(inline: '<span class="label label-success">Registrada</span>')
        elsif brand.estado == 'Caducada'
            render(inline: '<span class="label label-danger">Caducada</span>')
        end
    end

    def actividad_label(brand)
        if brand.actividad == 'Productos'
            render(inline: '<span class="label label-primary">Productos</span>')
        elsif brand.actividad == 'Servicios'
            render(inline: '<span class="label label-warning">Servicios</span>')
        end
    end

end
