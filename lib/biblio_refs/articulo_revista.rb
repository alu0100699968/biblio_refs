module BiblioRefs
  #Clase para representar referencias bibliográficas de un artículo.
  #Hereda de PublicacionesPeriodicas.
  class ArticuloRevista < PublicacionesPeriodicas

    attr_accessor :titulo_obra, :paginas, :volumen, :eds

    #Constructor de la clase ArticuloRevista
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

    #Método para asignar valores a los atributos titulo_obra, paginas, volumen y
    #eds cuando se crean los objetos mediante el DSL.
    def articulo(articulo = {})
      @titulo_obra = articulo[:titulo_obra]
      @paginas = articulo[:paginas]
      @volumen = articulo[:volumen]
      @eds = articulo[:eds]
    end

    #Método para devolver un String con la fecha_publicacion correctamente formateada
    def fecha_publicacion_to_s
      "(" + fecha_publicacion.year.to_s + "). "
    end

    #Método para devolver un String con los editores correctamente formateados
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

    #Método to_s de la clase que agrupa el resto de métodos 'to_s' declarados.
    def to_s
      final = autores_to_s + " " + fecha_publicacion_to_s
      final += "\n\t" + titulo_to_s + ". En " + eds_to_s + "(Eds.), "
      final += titulo_obra.to_s + " (" + paginas.to_s + ") " + "(" + num_edicion_to_s + ") "
      final += "(" + volumen.to_s + "). Lugar de publicación: " + editorial_to_s
    end

  end
end
