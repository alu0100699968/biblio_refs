module BiblioRefs
  #Clase para representar referencias bibliográficas de un artículo de periódico.
  #Hereda de PublicacionesPeriodicas.
  class ArticuloPeriodico < PublicacionesPeriodicas

    attr_accessor :nombre_periodico, :num_paginas

    #Constructor de la clase ArticuloPeriodico.
    def initialize(autores, fecha_publicacion, titulo, nombre_periodico, num_paginas)
      @autores = autores
      @fecha_publicacion = fecha_publicacion
      @titulo = titulo
      @nombre_periodico = nombre_periodico
      @num_paginas = num_paginas
    end

    #Método para asignar valores a los atributos nombre_periodico y
    #num_paginas cuando se crean los objetos mediante el DSL.
    def periodico(periodico = {})
      @nombre_periodico = periodico[:nombre_periodico]
      @num_paginas = periodico[:num_paginas]
    end

    #Método to_s de la clase que agrupa el resto de métodos 'to_s' declarados.
    def to_s
      final = autores_to_s + " (" + fecha_publicacion_to_s + "). "
      final += "\n\t" + titulo_to_s + ". " + nombre_periodico.to_s + ", pp. "
      final += num_paginas.to_s + "."
    end

  end
end
