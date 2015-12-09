# create a Struct with :value and :next
Nodo = Struct.new(:value, :next, :prev)

module BiblioRefs
	class List
		include Enumerable

    attr_accessor :head, :tail

		def initialize(*nodo)
      @tail = @head = Nodo.new(nodo[0], nil)
      if nodo.size > 1
        nodo.shift
        push(*nodo)
      end
    end

		def each
    	aux=@head
    	while aux[:next]
    		yield aux[:value]
    		aux=aux[:next]
    	end
    	yield aux[:value]
    end

    def pop
      nodo = @head
      @head = @head[:next]
      nodo[:value]
    end

    def push(*nodo)
      aux = @head
      nodo.each do |n|
        while aux[:next] do
          aux = aux[:next]
        end
        @tail = aux[:next] = Nodo.new(n, nil, aux)
      end
    end

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
