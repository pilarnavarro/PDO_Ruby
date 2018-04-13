#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'HangarToUI'
module Deepspace
  
  class Hangar
    attr_reader :maxElements,:shieldBoosters,:weapons
    def initialize(capacity)
      @maxElements=capacity
      @shieldBoosters=Array.new
      @weapons=Array.new
    end
    
    def self.newCopy(h)
      aux=Hangar.new(h.maxElements)
      if(!h.shieldBoosters.empty?)
        for i in (0..(h.shieldBoosters.length-1))
          aux.addShieldBooster(h.shieldBoosters[i])
        end
      end
      
      if(!h.weapons.empty?)
        for i in (0..(h.weapons.length-1))
          aux.addWeapon(h.weapons[i])
        end
      end 
      return aux
    
    end
   
    
    def spaceAvailable
      if maxElements>(shieldBoosters.length+weapons.length)
        return true
      end
      return false
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
      if w>=0
        return weapons.delete_at(w)
      end
      
      return nil
    end
    
    def removeShieldBooster(s)
      if s>=0
        return shieldBoosters.delete_at(s) 
      end
       return nil
    end
    
    def getUIversion()
      return HangarToUI.new(self)
    end
    
    def to_s
      aux="Máximo número de elementos que puede tener el hangar: #{maxElements}"
      if(!(shieldBoosters.empty?))
        aux+="\n\t\tPotenciadores de escudo: \n"
        for i in(0..(shieldBoosters.length-1))
          aux+="#{shieldBoosters[i].to_s}"
        end
      end
      
      if(!(weapons.empty?))
        aux+="\n\t\tArmas: \n"
        for j in(0..(weapons.length-1))
          aux+="#{weapons[j].to_s}"
        end
      end
      
      aux+="\n\n"
      
      return aux
    end
    
    private :spaceAvailable
    
  end
    
  end

