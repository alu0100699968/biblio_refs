Node = Struct.new(:value, :next)

module BiblioRefs
  class List

    attr_accessor :head

    def initialize(items)
      @head = Node.new(items, nil)
    end

    def pop
      aux = @head
      @head = @head[:next]
      aux[:value]
    end

    def push(items)
      aux = @head
      while aux[:next] do
        aux = aux[:next]
      end
      aux[:next] = Node.new(items, nil)
    end

    def to_s
      aux = @head
      salida = ""
      while aux[:next] do
        salida += "#{aux[:value]}"
        salida += " -> "
        aux = aux[:next]
      end
      salida += "#{aux[:value]}"
      salida
    end

  end
end
