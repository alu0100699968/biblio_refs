#Se crea un Struct para representar un Nodo con :value y :next
Nodo = Struct.new(:value, :next, :prev)

module BiblioRefs
	#Clase para representar una lista doblemente enlazada.
	class List
		include Enumerable

    attr_accessor :head, :tail

		#Constructor de la clase.
		#Recibe un número indefinido de nodos y los añade a la lista.
		def initialize(*nodo)
      @tail = @head = Nodo.new(nodo[0], nil)
      if nodo.size > 1
        nodo.shift
        push(*nodo)
      end
		end

		#Método para hacer la clase Enumerable.
		#Hace 'yield' a todos los elementos de la lista.
		def each
    	aux=@head
    	while aux[:next]
    		yield aux[:value]
    		aux=aux[:next]
    	end
    	yield aux[:value]
		end

		#Método que elimina el elemento a la cabeza de la lista y lo devuelve.
    def pop
      nodo = @head
      @head = @head[:next]
      nodo[:value]
    end

		#Método que añade uno o más nodos a la lista.
    def push(*nodo)
      aux = @head
      nodo.each do |n|
        while aux[:next] do
          aux = aux[:next]
        end
        @tail = aux[:next] = Nodo.new(n, nil, aux)
      end
    end

		#Método que muestra todos los elementos de la lista correctamente formateados.
    def to_s
      aux = @head
      string = "Lista: "
      while aux[:next] do
        string += "#{aux[:value]}" + " -> "
        aux = aux[:next]
      end
      string += "#{aux[:value]}"
    end
	end
end
