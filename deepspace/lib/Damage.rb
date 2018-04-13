#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'DamageToUI'
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
      for i in(0..(w.length-1))
        if (w[i].type==t)
          return i
        end
      end
      return -1
    end
    
    #Armasa del daño de las que dispongo y puedo darle a la arma enemiga
    def adjust(w,s)
      shields=nShields
      if s.length < nShields 
        shields=s.length
      end
      
      if weapons!=nil
        pendingweapons=Array.new()
        copy=Array.new()
        for i in(0..(w.length-1))          #Copio el array del parámetro en otro array de WeaponTypes
          copy.push(w[i].type)
        end           
        
        if(!copy.empty?)
          for i in(0..(weapons.length-1))
              indice=copy.find_index(weapons[i])
              if indice!=nil
                pendingweapons.push(copy[indice])
                copy.delete_at(indice)
              end
          end
        end
        
        if(pendingweapons.empty? && shields==0)
          return nil
        else
          return Damage.newSpecificWeapons(pendingweapons,shields)
        end
        
      else
        nweapons=nWeapons
        if w.length<nWeapons
          nweapons=w.length
        end
        
        if(nweapons==0 && shields==0)
          return nil
        else
          return Damage.newNumericWeapons(nweapons,shields)
        end
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
       
      if (weapons!=nil && !weapons.empty?)
        return "\tNúmero de escudos del daño: #{nShields} \n\tArmas que conlleva el daño:\n#{weapons.join('')}"
      else
        if nWeapons==-1
          @nWeapons=0
        end
        return "\tNúmero de escudos del daño: #{nShields} \n\tArmas que conlleva el daño: #{nWeapons}\n\n"
      end
    end
    
    private :arrayContainsType
    private_class_method :new
  end
end
