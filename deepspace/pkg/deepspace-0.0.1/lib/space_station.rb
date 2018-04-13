# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
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
    return fuelUnits/MAXFUEL 
  end
  
  def getUIversion()
    return SpaceStationToUI.new(this)
  end
  
  
  def assignFuelValue(f)
    if(j<=@@MAXFUEL && f>=0)
      @fuelUNits=f
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
    @hangar=nil
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
      aux=hangar.removeShieldBoosters(i)
      if(aux!=nil)
        shieldBoosters.push(aux)
      end
    end
  end
  
  def discardWeaponInHangar(i)
    if(hangar!=nil)
      hangar.removeWeapons(i)
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
    if(pendingDamage.hasNoEffect || pendingDamage==nil)
      return true
    else
      return false
    end
  end
  
  def cleanUpMountedItems
    for i in(0..(weapons.length-1))
      if(weapons[i].uses==0)
        weapons.pop(i)
      end
    end
    
    for j in(0..(shieldBoosters.length-1))
      if(shieldBoosters[j].uses==0)
        shieldBoosters.pop(j)
      end
    end
  end
  
  def fire
  end
  
  def protection
  end
  
  def receiveShot(shot)
  end
  
  def setLoot(loot)
  end
  
  def discardWeapon(i)
  end
  
  def discardShieldBooster(i)
  end
  
  def setPendingDamage(d)
    @pendingDamage=d;
  end
  
  def to_s
    aux= "Estación espacial  #{name} Potencia de armamento:  #{ammoPower}  Combustible: #{fuelUnits} Energía para los escudos #{shieldPower} Medallas: #{nMedals}"
    
    if(hangar!=nil)
      aux+="\nHangar: #{hangar.to_s}";
    end
    
    if(pendingDamage!=nil)
      aux+="\nDaño pendiente: #{pendingDamage.to_s}";
    end
    
    if !shieldBoosters.empty?
      aux+="\nPotenciadores de escudo montados: ";
      for i in(0..(shieldBoosters.length-1))
        shieldBoosters[i].to_s;
      end
    end
    
    if !weapons.empty? 
      aux+="\nArmas: "
      for j in(0..(weapons.length-1))
        weapons[j].to_s;
      end
    end
  
    return aux
  end
  
  private :assignFuelValue, :cleanPendingDamage
end
    
  

  
end

