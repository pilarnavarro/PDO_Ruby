# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Deepspace
  class Damage
    attr_reader :nShields, :nWeapons, :weapons
    
    def initialize(wl,w,s)
      @nShields=s
      @nWeapons=w
      @weapons=wl
    end
    
    def self.newNumericWeapons(w,s)
      new(nil,w,s)
    end
    
    def self.newSpecificWeapons(wl,s)
      new(wl,-1,s)
    end
    
    def self.newCopy(d)
      new(d.weapons,d.nWeapons,d.nShields)
    end
    
    def getUIversion
      return DamageToUI.new(self);
    end
    
    def discardShieldBooster
      if nShields>0
        @nShields-=1;
      end      
    end
    
    def discardWeapon(w)
      if weapons!=nil
        i=@weapons.find_index(w.type)
        if i!=nil
          @weapons.delete_at(i)
        end
      elsif nWeapons>0
          @nWeapons-=1
      end
    end
    
    def arrayContainsType (w,t)
      for i in(0..w.length)
        if (w[i].type==t)
          return i
        end
      end
      return -1
    end
    
    def adjust(w,s)
      shields=0
      if s.length<nShields
        shields=nShields-s.length
      end
      
      if weapons!=nil
        pendingweapons=Array.new()
        pendingweapons=weapons  #Almaceno todas las armas que debo
        copy=Array.new()
        for i in(0..w.length)  #Copio el array del parámetro en otro array de WeaponTypes
          copy.push(w[i].type)
        end           
        #Recorro el array de las armas pendientes. Busco cada una de las
        #armas pendientes en el array de las armas que tengo(copy).
        #Si tengo la arma que debo la quito del array de las armas que debo
        #(pues la tengo) y del array de las que tengo(copy), pues ya no la tengo dado
        #que la debo. Así, finalmente tengo en el array pendingweapons las armas
        #de las que no dispongo para dar.
        for i in(0..pendingweapons.lenght)
          if(!copy.empty?)
            indice=copy.find_index(pendingweapons[i])
            if indice!=nil
              copy.delete_at(indice)
              pendingweapons.delete_at(i)
            end
          end
        end
       return Damage.newSpecificWeapons(pendingweapons,shields)
      else
        nweapons=0
        if w.length<nWeapons
          nweapons=nWeapons-w.length
        end       
        return Damage.newNumericWeapons(shields,nweapons)
     
      end   
      
    end
    
    def hasNoEffect
        if weapons!=nil
          if (nShields==0 && weapons.size==0)
            return true
          else
            return false
          end
        elsif (nShields==0 && nWeapons==0)
          return true
        else
          return false;
        end     
    end
    
    def to_s
      mensaje="Número de escudos del daño #{nShields}, armas que conlleva el daño:"
      
      if weapons!=nil
        for i in(0..wepons.lenght)
          mensaje+=weapons[i].to_s
        end
      else
        mensaje+="#{nWeapons}"
      end
      return mensaje
    end
    
    private_class_method :new
  end
end
