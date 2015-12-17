require 'date'

module BiblioRefs
  #Clase que representa una referencia bibliográfica estándar y de la que
  #heredan el resto de clases
  class Referencia
    include Comparable
    attr_accessor :autores, :titulo, :serie, :editorial, :num_edicion, :fecha_publicacion, :isbn

    #Método que crea un objeto de la clase hija que lo llame
    #Se utiliza para crear un objeto y llamar a los métodos
    #que asignarán valores a sus atributos.
    def self.crear(&block)
      if self == BiblioRefs::Libro
        nuevo = self.new(nil, nil, nil, nil, nil, nil)
      elsif self == BiblioRefs::ArticuloRevista
        nuevo = self.new(nil, nil, nil, nil, nil, nil, nil, nil, nil)
      elsif self == BiblioRefs::ArticuloPeriodico
        nuevo = self.new(nil, nil, nil, nil, nil)
      elsif self == BiblioRefs::DocumentoElectronico
        nuevo = self.new(nil, nil, nil, nil, nil, nil, nil, nil)
      else
        puts "No funciona NADA."
      end
      nuevo.instance_eval &block
      nuevo
    end

    #Constructor de la clase madre
    def initialize(autores, titulo, serie = nil, editorial, num_edicion, fecha_publicacion, isbn)
      @autores = autores
      @titulo = titulo
      @serie = serie
      @editorial = editorial
      @num_edicion = num_edicion
      @fecha_publicacion = fecha_publicacion
      @isbn = isbn
    end

    #Método para asignar valores al atributo autores cuando se crean los
    #objetos mediante el DSL.
    def autor(autor = {})
      if @autores == nil
        @autores = "#{autor[:apellido]}, #{autor[:nombre]}"
      elsif @autores.kind_of?Array
        @autores << "#{autor[:apellido]}, #{autor[:nombre]}"
      else
        autores_array = [@autores]
        autores_array << "#{autor[:apellido]}, #{autor[:nombre]}"
        @autores = autores_array
      end
    end

    #Método para asignar valores al atributo titulo cuando se crean
    #los objetos mediante el DSL.
    def title(titulo = {})
      @titulo = titulo
    end

    #Método para asignar valores a los atributos editorial, num_edicion y
    #fecha_publicacion cuando se crean los objetos mediante el DSL.
    def info(info = {})
      @editorial = info[:editorial]
      @num_edicion = info[:num_edicion]
      @fecha_publicacion = Date.parse(info[:fecha_publicacion])
    end

    #Método para devolver un String con los autores correctamente formateados.
    def autores_to_s
      final = ""
      if autores.kind_of?(Array)
        autores.each do |autor|
          final += autor
          final += " & "
        end
        final[-2..-1] = ""
      else
        final += autores
        final += " "
      end
      final.chop
    end

    #Método para devolver un String con el título correctamente formateado
    def titulo_to_s
      titulo.to_s
    end

    #Método para devolver un String con la serie correctamente formateada
    def serie_to_s
      if serie != nil
        "(" + serie.to_s + ")"
      end
    end

    #Método para devolver un String con la editorial correctamente formateado
    def editorial_to_s
      editorial.to_s
    end

    #Método para devolver un String con el num_edicion correctamente formateado
    def num_edicion_to_s
      num_edicion.to_s + " edition"
    end

    #Método para devolver un String con la fecha_publicacion correctamente formateada
    def fecha_publicacion_to_s
      Date::MONTHNAMES[fecha_publicacion.mon] + " " + fecha_publicacion.day.to_s + ", " + fecha_publicacion.year.to_s
    end

    #Método para devolver un String con el ISBN correctamente formateado
    def isbn_to_s
      final = ""
      if isbn.kind_of?(Array)
        isbn.each do |num|
          if num.length > 12
            final += "ISBN-13: " + num + "\n"
          else
            final += "ISBN-10: " + num + "\n"
          end
        end
        final.chop
      else
        if isbn.length > 12
          final += "ISBN-13: " + isbn
        else
          final += "ISBN-10: " + isbn
        end
      end
    end

    #Método to_s de la clase que agrupa el resto de métodos 'to_s' declarados.
    def to_s
      final = autores_to_s + ".\n" + titulo_to_s + "\n"
      if serie != nil
        final += serie_to_s + "\n"
      end
      final += editorial_to_s + "; " + num_edicion_to_s + " (" + fecha_publicacion_to_s + ")\n" + isbn_to_s
    end

    #Método para definir cómo se comparan los objetos de la jerarquía de clases.
    def <=>(ref)
      if ref.is_a?BiblioRefs::Referencia
        if(@autores.kind_of?(Array) && ref.autores.kind_of?(Array))
          if((@autores[0] <=> ref.autores[0]) == 0)
            if((@fecha_publicacion <=> ref.fecha_publicacion) == 0)
              @titulo <=> ref.titulo
            else
              @fecha_publicacion <=> ref.fecha_publicacion
            end
          else
            @autores[0] <=> ref.autores[0]
          end
        else
          if(@autores.kind_of?(Array) && !ref.autores.kind_of?(Array))
            if((@autores[0] <=> ref.autores) == 0)
              if((@fecha_publicacion <=> ref.fecha_publicacion) == 0)
                @titulo <=> ref.titulo
              else
                @fecha_publicacion <=> ref.fecha_publicacion
              end
            else
              @autores[0] <=> ref.autores
            end
          else
            if(!@autores.kind_of?(Array) && ref.autores.kind_of?(Array))
              if((@autores <=> ref.autores[0]) == 0)
                if((@fecha_publicacion <=> ref.fecha_publicacion) == 0)
                  @titulo <=> ref.titulo
                else
                  @fecha_publicacion <=> ref.fecha_publicacion
                end
              else
                @autores <=> ref.autores[0]
              end
            else
              if((@autores <=> ref.autores) == 0)
                if((@fecha_publicacion <=> ref.fecha_publicacion) == 0)
                  @titulo <=> ref.titulo
                else
                  @fecha_publicacion <=> ref.fecha_publicacion
                end
              else
                @autores <=> ref.autores
              end
            end
          end
        end
      else
        nil
      end
    end

    #Método para comprobar si dos objetos de la jerarquía son iguales.
    def ==(ref)
      if ref.is_a?Referencia
        self.to_s == ref.to_s
      else
        false
      end
    end

  end
end
