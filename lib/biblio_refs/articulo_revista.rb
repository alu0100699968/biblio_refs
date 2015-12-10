module BiblioRefs
  class ArticuloRevista < PublicacionesPeriodicas

    attr_accessor :titulo_obra, :paginas, :volumen, :eds

    def initialize(autores, titulo, titulo_obra, editorial, num_edicion, fecha_publicacion, volumen, paginas, eds)
      @autores = autores
      @titulo = titulo
      @titulo_obra = titulo_obra
      @editorial = editorial
      @num_edicion = num_edicion
      @fecha_publicacion = fecha_publicacion
      @volumen = volumen
      @paginas = paginas
      @eds = eds
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

    def fecha_publicacion_to_s
      "(" + fecha_publicacion.year.to_s + "). "
    end

    def eds_to_s
      final = ""
      if eds.kind_of?(Array)
        eds.each do |ed|
          final += ed
          final += " & "
        end
        final[-1] = ""
      else
        final += eds
        final += "  "
      end
      final.chop
    end

    def to_s
      final = autores_to_s + fecha_publicacion_to_s
      final += "\n\t" + titulo_to_s + ". En " + eds_to_s + "(Eds.), "
      final += titulo_obra.to_s + " (" + paginas.to_s + ") " + "(" + num_edicion_to_s + ") "
      final += "(" + volumen.to_s + "). Lugar de publicación: " + editorial_to_s
    end

  end
end
