module BiblioRefs
  class ArticuloPeriodico < PublicacionesPeriodicas

    attr_accessor :nombre_periodico, :num_paginas

    def initialize(autores, fecha_publicacion, titulo, nombre_periodico, num_paginas)
      @autores = autores
      @fecha_publicacion = fecha_publicacion
      @titulo = titulo
      @nombre_periodico = nombre_periodico
      @num_paginas = num_paginas
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

    def to_s
      final = autores_to_s + "(" + fecha_publicacion_to_s + "). "
      final += "\n\t" + titulo_to_s + ". " + nombre_periodico.to_s + ", pp. "
      final += num_paginas.to_s + "."
    end

  end
end
