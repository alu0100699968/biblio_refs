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

  end
end
