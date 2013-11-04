module CorporationsHelper

    def status_label(corporation)
        status = corporation.status
        if status == 'VIGENTE'
            render(inline: '<span class="label label-success">Vigente</span>')
        elsif status == 'DISUELTA'
            render(inline: '<span class="label label-danger">Disuelta</span>')
        elsif status == 'REDOMICILIO PROVISIONAL'
            render(inline: '<span class="label label-info">Redomicilio Provisional</span>')
        elsif status == 'REDOMICILIO DEFINITIVO'
            render(inline: '<span class="label label-primary">Redomicilio Definitivo</span>')
        elsif status == 'FUSION'
            render(inline: '<span class="label label-warning">Fusion</span>')
        elsif status == 'TRANSFORMACION'
            render(inline: '<span class="label label-default">Transformacion</span>')
        end
    end


end
