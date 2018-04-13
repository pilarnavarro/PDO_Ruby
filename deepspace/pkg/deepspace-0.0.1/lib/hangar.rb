# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module Deepspace
  
  class Hangar
    attr_reader :maxElements,:shieldBoosters,:weapons
    def initialize(capacity)
      @maxElements=capacity
      @shieldBoosters=Array.new
      @weapons=Array.new
    end
    
    def self.newCopy(h)
      new(h.capability)
    end
    
    def spaceAvailable
      if maxElements<(shieldBoosters.length+weapons.length)
        return false
      end
      return true
    end
    
    def addWeapon(w)
      if spaceAvailable
        weapons.push(w)
        return true
      else
        return false
      end
    end
    
    def addShieldBooster(s)
      if spaceAvailable
        shieldBoosters.push(s)
        return true
      else
        return false
      end
    end
    
    def removeWeapon(w)
      return weapons.delete_at(w)
    end
    
    def removeShieldBooster(s)
      return shieldBoosters.delete_at(s) 
    end
    
    def getUIversion()
      return HangarToUI.new(this)
    end
    
    def to_s
      puts "Máximo número de elementos que puede tener el hangar: #{maxElements}"
      if(!(shieldBooster.empty?))
        puts "\nPotenciadores de escudo: "
        for i in(0..(shieldBoosters.length-1))
          shieldBoosters[i].to_s;
        end
      end
      
      if(!(weapons.empty?))
        puts "\nArmas: "
        for j in(0..(weapons.length-1))
          weapons[j].to_s;
        end
      end

    end
    
    private :spaceAvailable
    
    
    
    
    
  end
end
