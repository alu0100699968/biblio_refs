require 'date'

module BiblioRefs
  class Referencia
    include Comparable
    attr_accessor :autores, :titulo, :serie, :editorial, :num_edicion, :fecha_publicacion, :isbn

    #def initialize(&block)
    #  instance_eval &block
    #end

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

    def initialize(autores, titulo, serie = nil, editorial, num_edicion, fecha_publicacion, isbn)
      @autores = autores
      @titulo = titulo
      @serie = serie
      @editorial = editorial
      @num_edicion = num_edicion
      @fecha_publicacion = fecha_publicacion
      @isbn = isbn
    end

    def autor(autor = {})
      if @autores == nil
        @autores = "#{autor[:apellido]}, #{autor[:nombre]}"
      elsif @autores.kind_of?Array
        @autorea << "#{autor[:apellido]}, #{autor[:nombre]}"
      else
        autores_array = [@autores]
        autores_array << "#{autor[:apellido]}, #{autor[:nombre]}"
        @autores = autores_array
      end
    end

    def title(titulo = {})
      @titulo = titulo
    end

    def info(info = {})
      @editorial = info[:editorial]
      @num_edicion = info[:num_edicion]
      @fecha_publicacion = Date.parse(info[:fecha_publicacion])
    end

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

    def titulo_to_s
      titulo.to_s
    end

    def serie_to_s
      if serie != nil
        "(" + serie.to_s + ")"
      end
    end

    def editorial_to_s
      editorial.to_s
    end

    def num_edicion_to_s
      num_edicion.to_s + " edition"
    end

    def fecha_publicacion_to_s
      Date::MONTHNAMES[fecha_publicacion.mon] + " " + fecha_publicacion.day.to_s + ", " + fecha_publicacion.year.to_s
    end

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

    def to_s
      final = autores_to_s + ".\n" + titulo_to_s + "\n"
      if serie != nil
        final += serie_to_s + "\n"
      end
      final += editorial_to_s + "; " + num_edicion_to_s + " (" + fecha_publicacion_to_s + ")\n" + isbn_to_s
    end

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

    def ==(ref)
      if ref.instance_of?Referencia
        self.to_s == ref.to_s
      else
        false
      end
    end

  end
end
