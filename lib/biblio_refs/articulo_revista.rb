module BiblioRefs
  class ArticuloRevista < PublicacionesPeriodicas

    attr_accessor :paginas, :volumen, :eds

    def initialize(autores, titulo, editorial, num_edicion, fecha_publicacion, volumen, paginas, eds)
      @autores = autores
      @titulo = titulo
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

  end
end
