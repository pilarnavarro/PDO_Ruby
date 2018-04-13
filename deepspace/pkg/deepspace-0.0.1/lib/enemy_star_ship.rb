# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module Deepspace
  class EnemyStarShip
    
    attr_reader :ammoPower, :name, :damage, :loot, :shieldPower
    def initialize(n, a, s, l, d)
      @ammoPower=a
      @name=n
      @shieldPower=s
      @loot=l
      @damage=d
    end
    
    def self.newCopy(e)
      new(e.name,e.ammoPower,e.shieldPower,e.loot,e.damage)
    end
    
    def getUIversion
      return EnemyToUI.new(self);
    end
    
    def fire
      @ammoPower
    end
    
    def protection
      @shieldPower
    end
    
    def receiveShot(shot)
        if @shieldPower<shot
            return ShotResult::DONOTRESIST;
        else
            return ShotResult::RESIST;
        end
    end
    
    def to_s
      puts "#{name} tiene una potencia de disparo de #{ammoPower} potencia de escudo #{shieldPower}"
      puts "\nBotín en caso de vencerla "
      loot.to_s
      puts "\nDaño en caso de derrota "
      damage.to_s
    end
  end
end
