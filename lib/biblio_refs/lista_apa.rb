module BiblioRefs
  #Clase para representar una lista de referencias en el formato APA.
  class ListaAPA
    attr_accessor :lista

    #Constructor de la clase.
    def initialize(lista)
      @lista = lista
      ordenar
    end

    #Método que ordena las referencias de la clase según el criterio del
    #método '<=>' de la clase madre de la jerarquía.
    def ordenar
      array = @lista.sort
      lista_aux = BiblioRefs::List.new(array[0])
      array.shift
      array.each do |ref|
        lista_aux.push(ref)
      end
      @lista = lista_aux
    end

    #Método que devuelve un String con las referencias de la lista correctamente
    #formateadas.
    def to_s
      class << @lista #Se accede a la eigenclass de @lista para redefinir el método to_s
        def to_s
          aux = @head
          string = ""
          while aux[:next] do
            string += "#{aux[:value]}" + "\n\n"
            aux = aux[:next]
          end
          string += "#{aux[:value]}"
        end
      end
      @lista.to_s
    end
  end
end
