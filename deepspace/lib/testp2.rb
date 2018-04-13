#encoding: utf-8
require_relative 'Loot.rb'
require_relative 'Dice.rb'
require_relative 'CombatResult.rb'
require_relative 'GameCharacter.rb'
require_relative 'ShieldBooster.rb'
require_relative 'ShotResult.rb'
require_relative 'Weapon.rb'
require_relative 'WeaponType.rb'
require_relative 'SuppliesPackage.rb'
require_relative 'Hangar.rb'
require_relative 'Damage.rb'
require_relative 'EnemyStarShip.rb'
require_relative 'GameUniverse.rb'
require_relative 'SpaceStation.rb'
require 'pp'


module Testp2
  class P2
    def main
      #weapons
      w1 = Deepspace::Weapon.new("weapon", Deepspace::WeaponType::LASER, 0)
      w2 = Deepspace::Weapon.new("weapon2", Deepspace::WeaponType::MISSILE, 1)
      w3 = Deepspace::Weapon.new("weapon3", Deepspace::WeaponType::PLASMA, 3)
      w4 = Deepspace::Weapon.new("weapon4", Deepspace::WeaponType::LASER, 2)
      
      #shieldbooster
      s1 = Deepspace::ShieldBooster.new("shield1", 5, 6)
      s2 = Deepspace::ShieldBooster.new("shield2", 3, 0) 
      
      d1 = Deepspace::Damage.newNumericWeapons(2,3)
      ws2 = Array.new
      ws2.push(Deepspace::WeaponType::LASER)
      ws2.push(Deepspace::WeaponType::LASER)

      d2 = Deepspace::Damage.newSpecificWeapons(ws2, 1)
       
      ws1 = Array.new
      ws1.push(w1)
      ws1.push(w2)
      ws1.push(w3)
      ws1.push(w4)
      
      ss1= Array.new
      ss1.push(s1)
      ss1.push(s1)
      
      puts "#{ws1.join('')}"
      puts "#{ss1.join('')}"
      
      puts "Prueba del adjust numérico: debería salir 2 y 2"
      adj1 = d1.adjust(ws1, ss1)
      puts adj1.to_s
      
      puts "Prueba del adjust específico, debería sacar dos lásers"
      adj2 = d2.adjust(ws1, ss1)
      puts adj2.to_s
      
      puts "Prueba descarte de armas, debería salir un vector con un láser"
      adj2.discardWeapon(w1)      
      puts adj2.to_s
      
     puts "Prueba hasnoeffect, debe dar false: #{adj2.hasNoEffect}"
   
     #Pruebas para ver que no se quitan cosas de más ni falla
     adj2.discardShieldBooster
     adj2.discardShieldBooster
     adj2.discardWeapon(w1)
     puts adj2.to_s
     puts "Prueba2 hasnoeffect, debe dar true: #{adj2.hasNoEffect}"
      
    adj1.discardWeapon(w1)
    puts "nWeapons debe salir 1:"
    puts adj1.to_s
    
    
    
    #Probamos la clase enemystarship
    puts "\n\nProbamos la clase enemystarship"
    e1 = Deepspace::EnemyStarShip.new("Flota imperial",5,4, Deepspace::Loot.new(1,2,3,4,5), d1)
    e2 = Deepspace::EnemyStarShip.new("Enemigo",5,1, Deepspace::Loot.new(1,2,3,4,5), d2)
    puts e1.to_s 
    puts e2.to_s
    
    puts "ReceiveShot(debe salir resits:  #{e1.receiveShot(4)}"
   
      
    puts "\n\nProbamos hangar"
    h1 = Deepspace::Hangar.new(3)
    puts h1.to_s
    
    h1.addWeapon(w1)
    puts h1.to_s
    
     h2=Deepspace::Hangar.newCopy(h1)
    
    puts "Hangar copia: "
    puts h2.to_s
   
      
    h1.addShieldBooster(s1)
    h1.addShieldBooster(s2)
    h1.addWeapon(w2)

    puts h1.to_s
    
    puts "Remove arma1 y escudo1"
    h1.removeWeapon(0)
    h1.removeShieldBooster(0)
    puts h1.to_s
   
    puts "\n\nProbamos la clase SpaceStation"
    p1 = Deepspace::SuppliesPackage.new(1.1,2.2,3.3)
    station1 = Deepspace::SpaceStation.new("Alianza rebelde", p1)
    puts station1.to_s
    
    puts "Eliminamos las armas montadas: "
    station1.cleanUpMountedItems
    puts station1.to_s
   
    
    station1.receiveWeapon(w1)
    puts "\nDebe salir igual que antes, recibe arma"
    puts station1.to_s
    
    station1.receiveHangar(h1)
    puts "\nRecibe hangar1"
    puts station1.to_s
    
    puts "Recibe arma"
    station1.receiveWeapon(w1)
    puts station1.to_s

    puts "Recibe dos escudos:\n"
    station1.receiveShieldBooster(s1)
    station1.receiveShieldBooster(s1)
    puts station1.to_s
    
    puts "Ajustamos daño pendiente: "
    station1.setPendingDamage(d1)
    puts station1.to_s

    puts "\n\nProbando receiveSupplies"
    station1.receiveSupplies(p1)
    puts station1.to_s

    puts "Sse monta el arma y el potenciados de escudo con indice 0: "
    station1.mountWeapon(0)
    station1.mountShieldBooster(0)
    puts station1.to_s
  
    puts "\ngetSpeed"
    puts station1.getSpeed
    
    puts "\nmove"
    pp station1.move
    puts station1.to_s
    
    puts "\nDiscard in hangar"
    h1.addWeapon(w2)
    station1.discardWeaponInHangar(0)
    puts station1.to_s
    
    puts "\nClean mounted items"
    station1.mountShieldBooster(0)
    puts station1.to_s
    station1.cleanUpMountedItems
    puts station1.to_s
    
    puts "Valid state: #{station1.validState}"
     
    end
  end
  
  p = P2.new
  p.main
end
