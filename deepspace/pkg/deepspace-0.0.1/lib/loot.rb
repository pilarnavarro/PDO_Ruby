# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module Deepspace
  class Loot
    def initialize(n_supplies,n_weapons,n_shields,n_hangars,n_medals)
      @nSupplies=n_supplies
      @nWeapons=n_weapons
      @nShields=n_shields
      @nHangars=n_hangars
      @nMedals=n_medals
    end

    def nSupplies
      @nSupplies
    end

    def nWeapons
      @nWeapons
    end

    def nShields
      @nShields
    end

    def nHangars
      @nHangars
    end

    def nMedals
      @nMedals
    end
    
    def getUIversion()
      return LootToUI(this).new
    end
    
    def to_s
      puts "#{nSupplies} suministros,#{nWeapons} armas,#{nShields} 
        potenciadores de escudo,#{nHangars} hangares, #{nMedals} medallas"
    end
  end
end