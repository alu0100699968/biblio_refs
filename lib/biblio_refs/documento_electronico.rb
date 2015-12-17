module BiblioRefs
  #Clase para representar referencias bibliográficas de un documento electrónico.
  #Hereda de PublicacionesPeriodicas.
  class DocumentoElectronico < PublicacionesPeriodicas

    attr_accessor :tipo_medio, :via, :fecha_acceso

    #Constructor de la clase.
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

    #Método para asignar valores a los atributos tipo_medio, via y
    #fecha_acceso cuando se crean los objetos mediante el DSL.
    def documento(documento = {})
      @tipo_medio = documento[:tipo_medio]
      @via = documento[:via]
      @fecha_acceso = Date.parse(documento[:fecha_acceso])
    end

    #Método para devolver un String con la fecha_acceso correctamente formateada
    def fecha_acceso_to_s
      Date::MONTHNAMES[fecha_publicacion.mon] + " " + fecha_publicacion.day.to_s + ", " + fecha_publicacion.year.to_s
    end

    #Método to_s de la clase que agrupa el resto de métodos 'to_s' declarados.
    def to_s
      final = autores_to_s + " (" + fecha_publicacion_to_s + "). "
      final += "\n\t" + titulo_to_s + " (" + num_edicion_to_s + "), " + "[" + tipo_medio + "]. "
      final += "Lugar de publicación: " + editorial_to_s + ". Disponible en: " + via.to_s
      final += " [" + fecha_acceso_to_s + "]"
    end

  end
end
