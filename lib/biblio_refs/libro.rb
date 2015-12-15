module BiblioRefs
  class Libro < Referencia

    attr_accessor :volumen

    def initialize(autores, titulo, editorial, num_edicion, fecha_publicacion, volumen)
      @autores = autores
      @titulo = titulo
      @editorial = editorial
      @num_edicion = num_edicion
      @fecha_publicacion = fecha_publicacion
      @volumen = volumen
    end

    def libro(libro = {})
      @volumen = libro
    end

    def fecha_publicacion_to_s
      "(" + fecha_publicacion.year.to_s + "). "
    end

    def to_s
      final = autores_to_s + " " + fecha_publicacion_to_s
      final += "\n\tTítulo del libro: " + titulo_to_s + " (" + num_edicion_to_s + ") "
      final += "(" + volumen.to_s + "). " + "Lugar de publicación: " + editorial_to_s + "."
    end

  end
end
