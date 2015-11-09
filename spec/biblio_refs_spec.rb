require 'spec_helper'


describe BiblioRefs do

  before :each do

    @ref1 = BiblioRefs::Referencia.new(["Dave Thomas", "Andy Hunt", "Chad Fowler"], "Programming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide", "The Facets of Ruby", "Pragmatic Bookshelf", 4, Date.parse('7th July 2013'), ['978-1937785499', '1937785491'])
    @ref2 = BiblioRefs::Referencia.new("J.R.R Tolkien", "El Hobbit", "Minotauro", 2, Date.parse('1st February 1982'), '0345538374')
  end

  describe "Comprobación de la inicialización de los atributos de la clase" do

    it 'Tiene un número de versión' do
      expect(BiblioRefs::VERSION).not_to be nil
    end

    it 'Deben de existir uno o más autores' do
      expect(@ref1.autores).not_to be nil
    end

    it 'Debe de existir un título' do
      expect(@ref1.titulo).not_to be nil
    end

    it 'Debe o no existir una serie' do
      expect(@ref1.serie).not_to be nil
      expect(@ref2.serie).to be nil
    end

    it 'Debe existir una editorial' do
      expect(@ref1.editorial).not_to be nil
      expect(@ref2.editorial).not_to be nil
    end

    it 'Debe existir un número de edición' do
      expect(@ref1.num_edicion).not_to be nil
      expect(@ref2.num_edicion).not_to be nil
    end

    it 'Debe existir una fecha de publicación' do
      expect(@ref1.fecha_publicacion).not_to be nil
      expect(@ref2.fecha_publicacion).not_to be nil
    end

    it 'Debe existir uno o más números ISBN' do
      expect(@ref1.isbn).not_to be nil
      expect(@ref2.isbn).not_to be nil
    end
  end

  describe "Comprobación de métodos to_s" do
    it 'Debe existir un método que devuelva los autores' do
      expect(@ref1.autores_to_s).to eq("Dave Thomas, Andy Hunt, Chad Fowler.")
      expect(@ref2.autores_to_s).to eq("J.R.R Tolkien.")
    end

    it 'Debe existir un método que devuelva el título' do
      expect(@ref1.titulo_to_s).to eq("Programming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide")
      expect(@ref2.titulo_to_s).to eq("El Hobbit")
    end

    it 'Debe existir un método que devuelva la serie' do
      expect(@ref1.serie_to_s).to eq("(The Facets of Ruby)")
      expect(@ref2.serie_to_s).to be nil
    end

    it 'Debe existir un método que devuelva la editorial' do
      expect(@ref1.editorial_to_s).to eq("Pragmatic Bookshelf")
      expect(@ref2.editorial_to_s).to eq("Minotauro")
    end

    it 'Debe existir un método que devuelva el número de edición' do
      expect(@ref1.num_edicion_to_s).to eq("4 edition")
      expect(@ref2.num_edicion_to_s).to eq("2 edition")
    end

    it 'Debe existir un método que devuelva la fecha de publicación' do
      expect(@ref1.fecha_publicacion_to_s).to eq("July 7, 2013")
      expect(@ref2.fecha_publicacion_to_s).to eq("February 1, 1982")
    end

    it 'Debe existir un método que devuelva el listado de números ISBN' do
      expect(@ref1.isbn_to_s).to eq("ISBN-13: 978-1937785499\nISBN-10: 1937785491")
      expect(@ref2.isbn_to_s).to eq("ISBN-10: 0345538374")
    end

    it 'Debe existir un método que devuelva la referencia formateada' do
      expect(@ref1.to_s).to eq ("Dave Thomas, Andy Hunt, Chad Fowler.\nProgramming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide\n(The Facets of Ruby)\nPragmatic Bookshelf; 4 edition (July 7, 2013)\nISBN-13: 978-1937785499\nISBN-10: 1937785491")
      expect(@ref2.to_s).to eq ("J.R.R Tolkien.\nEl Hobbit\nMinotauro; 2 edition (February 1, 1982)\nISBN-10: 0345538374")
    end
  end

  describe "Nodo" do

    before :each do
      @nodo = Node.new("Prueba", nil)
    end

    it 'Debe existir un Nodo de la lista con sus datos y su siguiente' do
      expect(@nodo[:value]).to eq("Prueba")
      expect(@nodo[:next]).to be nil
    end
  end

  describe "List" do

    before :each do
      @lista = BiblioRefs::List.new("prueba")
    end

    it 'Se extrae el primer elemento de la lista' do
      expect(@lista.pop).to eq("prueba")
    end

    it 'Se puede insertar un elemento' do
      @lista.push("abeurp")
      expect(@lista.to_s).to eq("prueba -> abeurp")
    end

    it 'Se pueden insertar varios elementos' do
      @lista.push(["prueba", 3, 2])
      expect(@lista.to_s).to eq("prueba -> 3 -> 2")
    end

  end
end
