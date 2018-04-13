#encoding:utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'loot.rb'
require_relative 'enumerado_examen.rb'

module Test
class Examen
  def initialize
    @contador=0
  end
  
   def contador
    return @contador
  end
  
  def contabilizar
    if @contador<10
      @contador += 1
    end
  end
  
  def principal
     
    mensaje=Deepspace::EnumeradoExamen::CUADRADO.to_s
    puts "Cuadrado -- #{mensaje}"
     
    loot1=Deepspace::Loot.newInitialize(0,0)
    loot2=Deepspace::Loot.new(0,0,3,2,0)
    
    puts "Botín creado con el nuevo constructor:"
    puts loot1.to_s
    
    puts "Botín creado con el antiguo constructor:"
    puts loot2.to_s
    
    figuras=Array.new
    figuras.push(Deepspace::EnumeradoExamen::CIRCULO)
    figuras.push(Deepspace::EnumeradoExamen::CUADRADO)
    figuras.push(Deepspace::EnumeradoExamen::HEXAGONO)
    
    media=0
    for i in figuras
      media+=i.getMagnitud
    end
    
    media/=figuras.length
    puts "Media de las magnitudes: #{media}"
    
    contabilizar
    puts "\nContador: #{@contador}"
  end
end

p1=Examen.new
for i in (0..10)
  p1.principal
end
end