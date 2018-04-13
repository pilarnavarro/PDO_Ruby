# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Padre
  @duda=3
  @@duda=33
  def initialize(a)
    @duda=a
  end
  
  def self.duda
    @duda
  end
  
  private def privado
    puts "Privado"
  end 
  
  def imprimePadre
    puts @duda+1
    puts @@duda+q
    puts self.class.class.duda+1  #Devuelve la clase self, luego duda se aplica al método duda de la clase
  end
end

class Hija < Padre
  
  def initialize
    puts "Creando padre"
    super(555)  #SI no ponemos super no se llama al initialize del padre. En ruby nunca se pone super. en java si
  end
  def self.cambia
    @@duda=888
  end
  
  def otro
    privado  #funciona, aunque es privado del padre, porque no tenemos que poner ningún receptor explícito. 
  end
end

p=Padre.new(333)
p.imprimePadre
h=Hija.new(333)
puts "======="
Hija.cambia 
p.imprimePadre #la variable de clase de padre cambia, pues la ha cambiado la hija, esto es porblemático. Si nos creamos un atributo de la clase hija que se llama igual que uno del de clase y lo cambiamos, entonces se cambia tanto el de la hija como el del padre
h.imprimePadre   
#h=Hija.new  # si no tenemos initialize en la clase hija esto da error, porque llama al initialize de padre y este espera que se le pase un parámetro.
#Desde la clasee hija se puede acceder a un atributo de instancia porque no se pone un receptor explícito para cceder a él
#los atributos de instancia de la clase no se comparten con la hija, luego el imrimePadre da error al llamar al atributo de instancia de la clase duda, no la tiene inicializada esta clasee, es nil
#por eso es más recomendable usar atributos de instancia de la clase que atributos de clase.
# el puts de nil es vacio, no imprime nada. Si intentamos llamar a un método de nil entonces ya si da error.

#Una hija tiene una instancia dentro de esta de padre, es una sola instancia las dos clases juntas (dentro de toda hija hay un padre)
#Si estamos dentro de la misma instancia, el protected no nos sirve para nada en Ruby