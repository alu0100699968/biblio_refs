module BiblioRefs
  class DocumentoElectronico < PublicacionesPeriodicas

    attr_accessor :tipo_medio, :via, :fecha_acceso

    def initialize(autores, fecha_publicacion, titulo, num_edicion, tipo_medio, editorial, via, fecha_acceso)
      @autores = autores
      @fecha_publicacion = fecha_publicacion
      @titulo = titulo
      @num_edicion = num_edicion
      @tipo_medio = tipo_medio
      @editorial = editorial
      @via = via
      @fecha_acceso = fecha_acceso
    end

    def autores_to_s
      final = ""
      if autores.kind_of?(Array)
        autores.each do |autor|
          final += autor
          final += " & "
        end
        final[-1] = ""
      else
        final += autores
        final += "  "
      end
      final.chop
    end

    def fecha_acceso_to_s
      Date::MONTHNAMES[fecha_publicacion.mon] + " " + fecha_publicacion.day.to_s + ", " + fecha_publicacion.year.to_s
    end

    def to_s
      final = autores_to_s + "(" + fecha_publicacion_to_s + "). "
      final += "\n\t" + titulo_to_s + " (" + num_edicion_to_s + "), " + "[" + tipo_medio + "]. "
      final += "Lugar de publicación: " + editorial_to_s + ". Disponible en: " + via.to_s
      final += " [" + fecha_acceso_to_s + "]"
    end

  end
end
