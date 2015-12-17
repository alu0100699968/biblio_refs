module BiblioRefs
  #Clase para representar referencias bibliográficas de libros.
  #Hereda de Referencia.
  class Libro < Referencia

    attr_accessor :volumen

    #Constructor de la clase Libro
    def initialize(autores, titulo, editorial, num_edicion, fecha_publicacion, volumen)
      @autores = autores
      @titulo = titulo
      @editorial = editorial
      @num_edicion = num_edicion
      @fecha_publicacion = fecha_publicacion
      @volumen = volumen
    end

    #Método para asignar valores al atributo volumen cuando se crean
    #los objetos mediante el DSL.
    def libro(libro = {})
      @volumen = libro
    end

    #Método para devolver un String con la fecha_publicacion correctamente formateada
    def fecha_publicacion_to_s
      "(" + fecha_publicacion.year.to_s + "). "
    end

    #Método to_s de la clase que agrupa el resto de métodos 'to_s' declarados.
    def to_s
      final = autores_to_s + " " + fecha_publicacion_to_s
      final += "\n\tTítulo del libro: " + titulo_to_s + " (" + num_edicion_to_s + ") "
      final += "(" + volumen.to_s + "). " + "Lugar de publicación: " + editorial_to_s + "."
    end

  end
end
