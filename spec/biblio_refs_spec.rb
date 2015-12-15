require 'spec_helper'

describe BiblioRefs do
  before :each do
    @ref1 = BiblioRefs::Referencia.new(['Dave Thomas', 'Andy Hunt', 'Chad Fowler'], "Programming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide", 'The Facets of Ruby', 'Pragmatic Bookshelf', 4, Date.parse('7th July 2013'), ['978-1937785499', '1937785491'])
    @ref2 = BiblioRefs::Referencia.new('J.R.R Tolkien', 'El Hobbit', 'Minotauro', 2, Date.parse('1st February 1982'), '0345538374')
  end

  describe 'Comprobación de la inicialización de los atributos de la clase' do
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

  describe 'Comprobación de métodos to_s' do
    it 'Debe existir un método que devuelva los autores' do
      expect(@ref1.autores_to_s).to eq('Dave Thomas & Andy Hunt & Chad Fowler')
      expect(@ref2.autores_to_s).to eq('J.R.R Tolkien')
    end

    it 'Debe existir un método que devuelva el título' do
      expect(@ref1.titulo_to_s).to eq("Programming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide")
      expect(@ref2.titulo_to_s).to eq('El Hobbit')
    end

    it 'Debe existir un método que devuelva la serie' do
      expect(@ref1.serie_to_s).to eq('(The Facets of Ruby)')
      expect(@ref2.serie_to_s).to be nil
    end

    it 'Debe existir un método que devuelva la editorial' do
      expect(@ref1.editorial_to_s).to eq('Pragmatic Bookshelf')
      expect(@ref2.editorial_to_s).to eq('Minotauro')
    end

    it 'Debe existir un método que devuelva el número de edición' do
      expect(@ref1.num_edicion_to_s).to eq('4 edition')
      expect(@ref2.num_edicion_to_s).to eq('2 edition')
    end

    it 'Debe existir un método que devuelva la fecha de publicación' do
      expect(@ref1.fecha_publicacion_to_s).to eq('July 7, 2013')
      expect(@ref2.fecha_publicacion_to_s).to eq('February 1, 1982')
    end

    it 'Debe existir un método que devuelva el listado de números ISBN' do
      expect(@ref1.isbn_to_s).to eq("ISBN-13: 978-1937785499\nISBN-10: 1937785491")
      expect(@ref2.isbn_to_s).to eq('ISBN-10: 0345538374')
    end

    it 'Debe existir un método que devuelva la referencia formateada' do
      expect(@ref1.to_s).to eq ("Dave Thomas & Andy Hunt & Chad Fowler.\nProgramming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide\n(The Facets of Ruby)\nPragmatic Bookshelf; 4 edition (July 7, 2013)\nISBN-13: 978-1937785499\nISBN-10: 1937785491")
      expect(@ref2.to_s).to eq ("J.R.R Tolkien.\nEl Hobbit\nMinotauro; 2 edition (February 1, 1982)\nISBN-10: 0345538374")
    end
  end

  describe 'Nodo' do
    before :each do
      @nodo1 = Nodo.new('último', nil, nil)
      @nodo2 = Nodo.new('primero', @nodo1, nil)
      @nodo1[:prev] = @nodo2
    end

    it '#Debe existir un Nodo en la lista con sus datos y su siguiente' do
      expect(@nodo2[:value]).to eq('primero')
      expect(@nodo2[:next]).to eq(@nodo1)
    end

    it '#Debe exisitir un Nodo con su anterior' do
      expect(@nodo1[:prev]).to eq(@nodo2)
    end
  end

  describe 'List' do
    before :each do
      @lista1 = BiblioRefs::List.new('elemento')
      @lista2 = BiblioRefs::List.new('elemento1', 'elemento2')
    end

    it '#Debe existir una lista con su cabeza' do
      expect(@lista1.head[:value]).to eq('elemento')
      expect(@lista2.head[:value]).to eq('elemento1')
    end

    it '#Debe existir una lista con su cola' do
      expect(@lista1.tail[:value]).to eq('elemento')
      expect(@lista2.tail[:value]).to eq('elemento2')
    end

    it '#Se extrae el primer elemento de la lista' do
      expect(@lista1.pop).to eq('elemento')
      expect(@lista2.pop).to eq('elemento1')
    end

    it '#Se puede insertar un elemento' do
      @lista1.push('nuevo')
      expect(@lista1.head[:next][:value]).to eq('nuevo')
      expect(@lista2.tail[:prev][:value]).to eq('elemento1')
    end

    it '#Se pueden insertar varios elementos' do
      @lista1.push('nuevo1', 'nuevo2')
      expect(@lista1.head[:next][:value]).to eq('nuevo1')
      expect(@lista1.head[:next][:next][:value]).to eq('nuevo2')
      expect(@lista1.tail[:prev][:value]).to eq('nuevo1')
      expect(@lista1.tail[:prev][:prev][:value]).to eq('elemento')
    end

    it '#Debe existir un método que devuelve la lista formateada' do
      @lista1.push('elemento2', 'elemento3')
      expect(@lista1.to_s).to eq('Lista: elemento -> elemento2 -> elemento3')
    end
  end

  describe 'Lista de referencias' do
    before :each do
      @refa = BiblioRefs::Referencia.new(['Dave Thomas', 'Andy Hunt', 'Chad Fowler'], "Programming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide", 'The Facets of Ruby', 'Pragmatic Bookshelf', 4, Date.parse('7th July 2013'), ['978-1937785499', '1937785491'])
      @refb = BiblioRefs::Referencia.new('Scott Chacon', 'Pro Git 2009th Edition', 'Pro', 'Apress', 2009, Date.parse('27th August 2009'), ['978-1430218333', '1430218339'])
      @refc = BiblioRefs::Referencia.new(['David Flanagan', 'Yukihiro Matsumoto'], 'The Ruby Programming Language', "O'Reilly Media", 1, Date.parse('4th February 2008'), ['0596516177', '978-0596516178'])
      @refd = BiblioRefs::Referencia.new(['David Chelimsky', 'Dave Astels', 'Bryan Helmkamp', 'Dan North', 'Zach Dennis', 'Aslak Hellesoy'], 'The RSpec Book: Behaviour Driven Development with RSpec, Cucumber, and Friends', 'The Facets of Ruby', 'Pragmatic Bookshelf', 1, Date.parse('25th December 2010'), ['1934356379', '978-1934356371'])
      @refe = BiblioRefs::Referencia.new('Richard E. Silverman', 'Git Pocket Guide', "O'Reilly Media", 1, Date.parse('2nd August 2013'), ['1449325866', '978-1449325862'])

      @lista = BiblioRefs::List.new(@refa, @refb, @refc, @refd, @refe)
    end

    it '#Se puede crear una lista de Referencias Biográficas' do
      expect(@lista.to_s).to eq("Lista: #{@refa} -> #{@refb} -> #{@refc} -> #{@refd} -> #{@refe}")
    end
  end

  describe 'Jerarquía de clases' do
    before :each do
      @ref1 = BiblioRefs::PublicacionesPeriodicas.new
      @ref2 = BiblioRefs::ArticuloRevista.new('Hunt, H.A.', "Programming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide", 'Titulo Obra', 'Pragmatic Bookshelf', 4, Date.parse('7th July 2013'), 3, 43, ['Pepe, P.P', 'Juan, J.J'])
      @ref3 = BiblioRefs::ArticuloPeriodico.new('Pepe, P.P.', Date.parse('3rd june 2010'), 'Cambio Climático', 'El Mundo', 3)
      @ref4 = BiblioRefs::DocumentoElectronico.new('Pepe, P.P.', Date.parse('3rd june 2010'), 'Economía Hundida', 4, 'Blog', 'Editorial Humilde', 'web', Date.parse('4th July 2015'))
    end

    it 'La clase para representar referencias de publicaciones periódicas pertenece a la jerarquía de clases' do
      expect(@ref1).to be_a BiblioRefs::Referencia
    end

    it 'La clase para representar referencias de artículos de revista pertenece a la jerarquía de clases' do
      expect(@ref2).to be_a BiblioRefs::Referencia
      expect(@ref2).to be_a BiblioRefs::PublicacionesPeriodicas
    end

    it 'La clase para representar referencias de artículos de periódico pertenece a la jerarquía de clases' do
      expect(@ref3).to be_a BiblioRefs::Referencia
      expect(@ref3).to be_a BiblioRefs::PublicacionesPeriodicas
    end

    it 'La clase para representar referencias de documentos electrónicos pertenece a la jerarquía de clases' do
      expect(@ref4).to be_a BiblioRefs::Referencia
      expect(@ref4).to be_a BiblioRefs::PublicacionesPeriodicas
    end

    it 'Comprobando herencia' do
      expect(@ref4.is_a? BiblioRefs::Referencia).to eq(true)
    end
  end

  describe 'Haciendo la clase Referencia comparable' do
    before :each do
      @ref1 = BiblioRefs::Referencia.new('Scott Chacon', "Programming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide", 'The Facets of Ruby', 'Pragmatic Bookshelf', 4, Date.parse('7th July 2013'), ['978-1937785499', '1937785491'])
      @ref2 = BiblioRefs::Referencia.new('Scott Chacon', 'Pro Git 2009th Edition', 'Pro', 'Apress', 2009, Date.parse('27th August 2009'), ['978-1430218333', '1430218339'])
      @ref3 = BiblioRefs::Referencia.new('Scott Chacon', "Programming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide", 'The Facets of Ruby', 'Pragmatic Bookshelf', 4, Date.parse('7th July 2013'), ['978-1937785499', '1937785491'])
    end

    it 'Dos referencias son iguales' do
      expect(@ref1 == @ref3).to eq(true)
    end

    it 'Dos referencias son diferentes' do
      expect(@ref1 == @ref2).to eq(false)
    end

    it 'Una referencia de 2009 es más vieja que una de 2013' do
      expect(@ref2 < @ref3).to eq(true)
      expect(@ref2 > @ref3).to eq(false)
    end

    it 'Una referencia de 2013 es más moderna o igual que una de 2009' do
      expect(@ref3 >= @ref2).to eq(true)
    end

    it 'Dos referencias tienen la misma fecha de publicación' do
      expect(@ref1 >= @ref3).to eq(true)
      expect(@ref3 <= @ref1).to eq(true)
    end
  end

  describe 'Haciendo la clase Lista enumerable' do
    before :each do
      @lista1 = BiblioRefs::List.new(1, 2, 3)
      @lista2 = BiblioRefs::List.new(5, 6, 4)
      @lista3 = BiblioRefs::List.new(nil, 9)
      @lista4 = BiblioRefs::List.new(nil, false)

      @refa = BiblioRefs::Referencia.new('Scott Chacon', "Programming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide", 'The Facets of Ruby', 'Pragmatic Bookshelf', 4, Date.parse('7th July 2013'), ['978-1937785499', '1937785491'])
      @refb = BiblioRefs::Referencia.new('Scott Chacon', 'Pro Git 2009th Edition', 'Pro', 'Apress', 2009, Date.parse('27th August 2009'), ['978-1430218333', '1430218339'])
      @refc = BiblioRefs::Referencia.new('Scott Chacon', 'The Ruby Programming Language', "O'Reilly Media", 1, Date.parse('4th February 2008'), ['0596516177', '978-0596516178'])
      @refd = BiblioRefs::Referencia.new('Scott Chacon', 'The RSpec Book: Behaviour Driven Development with RSpec, Cucumber, and Friends', 'The Facets of Ruby', 'Pragmatic Bookshelf', 1, Date.parse('25th December 2010'), ['1934356379', '978-1934356371'])
      @refe = BiblioRefs::Referencia.new('Scott Chacon', 'Git Pocket Guide', "O'Reilly Media", 1, Date.parse('2nd August 2013'), ['1449325866', '978-1449325862'])

      @lista_ref = BiblioRefs::List.new(@refa, @refb, @refc, @refd, @refe)
    end

    it 'Comprobrando el metodo all? con un bloque vacio' do
      expect(@lista1.all?).to eq(true)
      expect(@lista3.all?).to eq(false)
    end

    it 'Comprobrando el metodo any?' do
      expect(@lista1.any?).to eq(true)
      expect(@lista3.any?).to eq(true)
      expect(@lista4.any?).to eq(false)
    end

    it 'Comprobrando el metodo collect' do
      expect(@lista1.map { |i| i * i }).to eq([1, 4, 9])
      expect(@lista2.collect { |i| i * i }).to eq([25, 36, 16])
    end

    it 'Comprobrando el metodo count' do
      expect(@lista1.count).to eq(3)
    end

    it 'Comprobrando el metodo detect' do
      expect(@lista1.detect { |i| i == 2 }).to eq(2)
      expect(@lista1.find { |i| i == 1 }).to eq(1)
      expect(@lista2.detect { |i| i == 1 }).to eq(nil)
    end

    it 'Comprobrando drop' do
      expect(@lista1.drop(2)).to eq([3])
    end

    it 'Comprobrando max' do
      expect(@lista2.max).to eq(6)
      expect(@lista_ref.max).to eq(@refe)
    end

    it 'Comprobrando min' do
      expect(@lista2.min).to eq(4)
      expect(@lista_ref.min).to eq(@refc)
    end

    it 'Comprobrando sort' do
      expect(@lista2.sort).to eq([4, 5, 6])
      expect(@lista_ref.sort).to eq([@refc, @refb, @refd, @refa, @refe])
    end
  end

  describe 'Lista APA' do
    before :each do
      @ref1 = BiblioRefs::ArticuloRevista.new('Hunt, H.A.', "Programming Ruby 1.9 & 2.0: The Pragmatic Programmers' Guide", 'Titulo Obra', 'Pragmatic Bookshelf', 4, Date.parse('7th July 2013'), 3, 43, ['Pepe, P.P', 'Juan, J.J'])
      @ref2 = BiblioRefs::ArticuloPeriodico.new('García, G.P.', Date.parse('3rd june 2010'), 'Cambio Climático', 'El Mundo', 3)
      @ref3 = BiblioRefs::DocumentoElectronico.new('Luis, L.M.', Date.parse('3rd june 2010'), 'Economía Hundida', 4, 'Blog', 'Editorial Humilde', 'web', Date.parse('4th July 2015'))

      @lista_refs = BiblioRefs::List.new(@ref1, @ref2, @ref3)

      @lista_apa = BiblioRefs::ListaAPA.new(@lista_refs)
    end

    it 'Se crea un objeto del tipo ListaAPA' do
      expect(@lista_apa).not_to be nil
    end

    it 'La lista debe ordenarse por orden alfabético según el apellido de los autores' do
      expect(@lista_apa.lista.to_s).to eq("Lista: #{@ref2} -> #{@ref1} -> #{@ref3}")
    end

    it 'La lista se muestra en el formato adecuado' do
      expect(@lista_apa.to_s).to eq("#{@ref2}\n\n#{@ref1}\n\n#{@ref3}")
    end
  end

  describe 'DSL' do
    before :each do
      @libro = BiblioRefs::Libro.crear do
        autor :apellido => 'Apellido',
              :nombre => 'Nombre'
        autor :apellido => 'Apellido2',
              :nombre => 'Nombre2'
        title 'Título'
        libro :volumen => 3
        info :editorial => 'Editorial',
             :num_edicion => 3,
             :fecha_publicacion => '1st June 2004'
      end

      @articulo = BiblioRefs::ArticuloRevista.crear do
        autor :apellido => 'Apellido',
              :nombre => 'Nombre'
        title  'Título'
        articulo  :titulo_obra => 'Título de Obra',
                  :paginas => 10,
                  :volumen => 3,
                  :eds => "Editor"
        info :editorial => 'Editorial',
             :num_edicion => 3,
             :fecha_publicacion => '1st June 2004'
      end

      @articulo_periodico = BiblioRefs::ArticuloPeriodico.crear do
        autor :apellido => 'Apellido',
              :nombre => 'Nombre'
        title  'Título'
        periodico :nombre_periodico => 'Nombre Periodico',
                  :num_paginas => 10
        info      :fecha_publicacion => '1st June 2004'
      end

      @documento = BiblioRefs::DocumentoElectronico.crear do
        autor :apellido => 'Apellido',
              :nombre => 'Nombre'
        title  'Título'
        documento :tipo_medio => 'Tipo de Medio',
                  :via => 'Tipo de vía',
                  :fecha_acceso => '15th June 2004'
        info :editorial => 'Editorial',
             :num_edicion => 3,
             :fecha_publicacion => '1st June 2004'
      end
    end

    it 'Se generan los objetos (comprobando el título)' do
      expect(@libro.titulo_to_s).to eq("Título")
      expect(@articulo.titulo_to_s).to eq("Título")
      expect(@articulo_periodico.titulo_to_s).to eq("Título")
      expect(@documento.titulo_to_s).to eq("Título")
    end

    it 'El nombre de los autores se pasa correctamente' do
      expect(@libro.autores_to_s).to eq("Apellido, Nombre & Apellido2, Nombre2")
      expect(@articulo.autores_to_s).to eq("Apellido, Nombre")
      expect(@articulo_periodico.autores_to_s).to eq("Apellido, Nombre")
      expect(@documento.autores_to_s).to eq("Apellido, Nombre")
    end
  end
end
