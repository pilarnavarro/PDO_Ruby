# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Deepspace
  class SuppliesPackage
    def initialize(armas,combustible,energia)
      @ammoPower=armas
      @fuelUnits=combustible
      @shieldPower=energia
    end

    def self.newCopy(copy)
      new(copy.ammoPower,copy.fuelUnits,copy.shieldPower)
    end

    def ammoPower
       @ammoPower
    end 

    def fuelUnits
       @fuelUnits
    end

    def shieldPower
      @shieldPower
    end

  end
end