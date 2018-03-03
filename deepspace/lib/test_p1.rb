#encoding:utf-8

require_relative 'loot.rb'
require_relative 'dice.rb'
require_relative 'CombatResult.rb'
require_relative 'game_character.rb'
require_relative 'shield_booster.rb'
require_relative 'shot_result.rb'
require_relative 'weapon.rb'
require_relative 'weapon_type.rb'
require_relative 'supplies_package.rb'


class TestP1
  def part1 
    loot1=Deepspace::Loot.new(2,3,1,3,4)
    booster1=Deepspace::ShieldBooster.new("Alto Voltaje", 50.32,3)
    booster2=Deepspace::ShieldBooster.newCopy(booster1)
    
    package1=Deepspace::SuppliesPackage.new(45.6,32.1, 78.6)
    package2=Deepspace::SuppliesPackage.newCopy(package1)  
    puts "El contenido de loot1 es #{loot1.nSupplies} suministros, #{loot1.nWeapons} armas, #{loot1.nShields} potenciadores de escudo, #{loot1.nHangars} hangares, #{loot1.nMedals} medallas" 
        
    puts "La información del primer potenciador de escudo es: Potencia #{booster1.boost} Usos #{booster1.uses}"
        
    puts "La información del segundo potenciador de escudo es: Potencia #{booster2.useIt} Usos #{booster2.uses}"
        
    puts "Paquete de suministros 1: Potencia de armamento #{package1.ammoPower}
    Combustible #{package1.fuelUnits} Energía para los escudos #{package1.shieldPower}"
        
    puts "Paquete de suministros 2: Potencia de armamento #{package2.ammoPower}
    Combustible #{package2.fuelUnits} Energía para los escudos #{package2.shieldPower}"
        
    weapon1=Deepspace::Weapon.new("arma1",Deepspace::WeaponType::LASER,1)
    weapon2=Deepspace::Weapon.newCopy(weapon1)
    puts "Nombre del arma 1: #{weapon1.name}"
    puts "Potencia del arma 1: #{weapon1.type.power}"
    puts "Nombre del arma 2: #{weapon2.name}"
    puts "Potencia del arma 2: #{weapon2.type.power}"
  end
  
    def part2
      mydice=Deepspace::Dice.new
      c1=[0,0]
      c2=[0,0]
      c3=[0,0]
      c4=[0,0,0]
      c5=[0,0]

      for i in(0..100)
        if mydice.firstShot==Deepspace::GameCharacter::SPACESTATION
          c2[0]+=1
        else
          c2[1]+=1
        end

        if mydice.spaceStationMoves(0.7)
          c1[0]+=1
        else
          c1[1]+=1
        end

        puts mydice.whoStarts(40)

        if mydice.initWithNHangars==0
          c3[0]+=1
        else
          c3[1]+=1
        end

        if mydice.initWithNWeapons==1
          c4[0]+=1
        elsif mydice.initWithNWeapons==2
          c4[1]+=1
        else
          c4[2]+=1
        end

        if mydice.initWithNShields==0
          c5[0]+=1
        else
          c5[1]+=1
        end
      end

      puts "La estación espacial se mueve: #{c1[0]}"
      puts "No se mueve: #{c1[1]}"
      puts "Dispara la estación espacial #{c2[0]}"
      puts "Dispara nave enemiga: #{c2[1]}"
      puts "La probabilidad de que initWithNHangars sea 0 es #{c3[0]}"
      puts "La probabilidad de que initWithNHangars sea 1 es #{c3[1]}"

      puts "La probabilidad de initWithNWeapons sea 1 es #{c4[0]}"
      puts "La probabilidad de initWithNWeapons sea 2 es #{c4[1]}"
      puts "La probabilidad de initWithNWeapons sea 3 es #{c4[2]}"

      puts "La probabilidad de initWithNShield sea 0 es #{c5[0]}"
      puts "La probabilidad de initWithNShield sea 1 es #{c5[1]}"

  end
  
end

test=TestP1.new

test.part1
test.part2


