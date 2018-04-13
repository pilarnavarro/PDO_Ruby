#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'SpaceStationToUI'
require_relative 'ShotResult'
module Deepspace
  
class SpaceStation
  attr_reader :ammoPower,:fuelUnits,:name,:nMedals,:shieldPower,:pendingDamage,
              :weapons,:shieldBoosters,:hangar
  
  
  @@MAXFUEL=100
  @@SHIELDLOSSPERUNITSHOT=0.1
  
  def initialize(n,supplies)
    @ammoPower=supplies.ammoPower;
    @fuelUnits=supplies.fuelUnits;
    @name=n;
    @nMedals=0;
    @shieldPower=supplies.shieldPower;
    @pendingDamage=nil
    @weapons=Array.new
    @shieldBoosters=Array.new
    @hangar=nil
  end
  
  def getSpeed
    return fuelUnits/@@MAXFUEL 
  end
  
  def getUIversion()
    return SpaceStationToUI.new(self)
  end
  
  
  def assignFuelValue(f)
    if(f<=@@MAXFUEL && f>=0)
      @fuelUnits=f
    end
  end
  
  def cleanPendingDamage()
    if(pendingDamage.hasNoEffect)
      @pendingDamage=nil
    end
  end
  
  def receiveWeapon(w)
    if(hangar!=nil)
      return hangar.addWeapon(w)
    else
      return false
    end
  end
  
  def receiveShieldBooster(s)
    if(hangar!=nil)
      return hangar.addShieldBooster(s)
    else
      return false
    end
  end
  
  def receiveHangar(h)
    if(hangar==nil)
      @hangar=h
    end
  end
  
  def discardHangar
    if(@hangar!=nil)
     @hangar=nil
    end
  end
  
  def receiveSupplies(s)
    @ammoPower+=s.ammoPower
    @shieldPower+=s.shieldPower
    @fuelUnits+=s.fuelUnits
  end 
  
  def setPendingDamage(d)
    @pendingDamage=d.adjust(weapons,shieldBoosters)
  end
  
  def mountWeapon(i)
    if(hangar!=nil)
      aux=hangar.removeWeapon(i)
      if(aux!=nil)
        weapons.push(aux)
      end
    end
  end
  
  def mountShieldBooster(i)
    if(hangar!=nil)
      aux=hangar.removeShieldBooster(i)
      if(aux!=nil)
        shieldBoosters.push(aux)
      end
    end
  end
  
  def discardWeaponInHangar(i)
    if(hangar!=nil)
      hangar.removeWeapon(i)
    end
  end
  
  def discardShieldBoosterInHangar(i)
    if(hangar!=nil)
      hangar.removeShieldBooster(i)
    end
  end
  
  def move
    aux=getSpeed()*fuelUnits;
    if(aux<=fuelUnits)
      @fuelUnits-=aux;
    else 
      @fuelUnits=0; 
    end
  end
  
  def validState
    
    if  pendingDamage==nil
        return true
    end
    
    if pendingDamage.hasNoEffect 
      return true
    else
      return false
    end
  end
  
  def cleanUpMountedItems
    aux=Array.new()
    if(!weapons.empty?)
    for i in(0..(weapons.length-1))
      if(weapons[i].uses==0)
        aux.push(i)
      end
    end
      if (!aux.empty?)
        for k in(0..(aux.length-1))
          weapons.delete_at(aux[k])
        end
        aux.clear
      end
    end
    
    if (!shieldBoosters.empty?)
    for j in(0..(shieldBoosters.length-1))
      if(shieldBoosters[j].uses==0)
        aux.push(j)
      end
    end
      if(!aux.empty?)
        for k in(0..(aux.length-1))
          shieldBoosters.delete_at(aux[k])
        end
      end
    end
  end
  
  def fire
    factor=1
    if(weapons!=weapons.empty?)
      for i in (0..(@weapons.length-1))
        w=@weapons[i]
        factor*=w.useIt
      end
    end
    return @ammoPower*factor
  end
  
  def protection
    factor=1
    if(shieldBoosters!=shieldBoosters.empty?)
      for i in (0..(@shieldBoosters.length-1))
        s=@shieldBoosters[i]
        factor*=s.useIt
      end
    end
    return @shieldPower*factor
  end
  
  
  def receiveShot(shot)
    myProtection=protection
    if myProtection>=shot
       aux=@@SHIELDLOSSPERUNITSHOT*shot
       if(aux<@shieldPower)
         @shieldPower-=aux
       else
         @shieldPower=0.0
       end
       return ShotResult::RESIST
    else
      @shieldPower=0.0
      return ShotResult::DONOTRESIST
    end
  end
  
  def setLoot(loot)
    dealer=CardDealer.instance
    
    h=loot.nHangars 
    if h>0
      hangar=dealer.nextHangar
      receiveHangar(hangar)
    end
    
    elements=loot.nSupplies
    
    while elements>0
      sup=dealer.nextSuppliesPackage
      receiveSupplies(sup)
      elements-=1
    end
    
    elements=loot.nWeapons
    
    while elements>0
      weap=dealer.nextWeapon
      receiveWeapon(weap)
      elements-=1
    end
    
    elements=loot.nShields
    
    while elements>0
      sh=dealer.nextShieldBooster
      receiveShieldBooster(sh)
      elements-=1
    end
    
    @nMedals+=loot.nMedals     
  end
  
  def discardWeapon(i)
    if i>=0 && i<@weapons.size
        w=@weapons.delete_at(i)
        if(pendingDamage!=nil)
          @pendingDamage.discardWeapon(w)
          cleanPendingDamage
        end
    end
  end
  
  def discardShieldBooster(i)
    if i>=0 && i<@shieldBoosters.size
        s=@shieldBoosters.delete_at(i)
        if(pendingDamage!=nil)
          @pendingDamage.discardShieldBooster
          cleanPendingDamage
        end
    end
  end
  
  def setPendingDamage(d)
    @pendingDamage=d.adjust(weapons,shieldBoosters);
  end
  
  def to_s
    aux="Estación espacial  #{name},potencia de armamento:  #{ammoPower}, combustible: #{fuelUnits}, Energía para los escudos #{shieldPower}, Medallas: #{nMedals}"
    
    if(hangar!=nil)
      aux+="\n\tHangar: "
      aux+="#{hangar.to_s}"
    end
    
    if(pendingDamage!=nil)
      aux+="\n\tDaño pendiente: "
      aux+="#{pendingDamage.to_s}"
    end
    
    if !shieldBoosters.empty?
      aux+="\n\tPotenciadores de escudo montados: "
      for i in(0..(shieldBoosters.length-1))
        aux+="#{shieldBoosters[i].to_s}";
      end
    end
    
    if !weapons.empty? 
      aux+="\n\tArmas: "
      for j in(0..(weapons.length-1))
        aux+="#{weapons[j].to_s}";
      end
    end
    aux+="\n\n"
    return aux
  end
  
  private :assignFuelValue, :cleanPendingDamage
end
  
end

