# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Deepspace
  class GameUniverse
    @@WIN=10
    def initialize
      @turns=0;
      @gameState=GameStateController.new()
      @dice=Dice.new()
      @spaceStations=Array.new()
    end
    
    def haveAWinner     
      if(@currentStation.nMedals>=@@WIN)
        return true
      end
      return false
    end
    
    def getUIVersion
      return GameUniverseToUI.new(currentStation, currentEnemy)
    end
    
    def getState
      @gameState.state
    end
    
    def discardShieldBooster(i)
      if(getState==GameState.INIT || getState==GameState.AFTERCOMBAT)
            @currentStation.discardShieldBooster(i);
      end
    end
    
    def discardHangar
      if(getState==GameState.INIT || getState==GameState.AFTERCOMBAT)
            @currentStation.discardHangar;
      end
    end

    def discardShieldBoosterInHangar(i)
      if(getState==GameState.INIT || getState==GameState.AFTERCOMBAT)
            @currentStation.discardShieldBoosterInHangar(i);
      end
    end
    
    def discardWeapon(i)
      if(getState==GameState.INIT || getState==GameState.AFTERCOMBAT)
            @currentStation.discardWeapon(i);
      end
    end
    
    def discardWeaponInHangar(i)
      if(getState==GameState.INIT || getState==GameState.AFTERCOMBAT)
            @currentStation.discardWeaponInHangar(i);
      end
    end
    
    def mountShieldBooster(i)
      if(getState==GameState.INIT || getState==GameState.AFTERCOMBAT)
            @currentStation.mountShieldBooster(i);
      end
    end
    
    def mountWeapon(i)
      if(getState==GameState.INIT || getState==GameState.AFTERCOMBAT)
            @currentStation.mountWeapon(i);
      end
    end
    
    def init(names)
      
    end
  
    def nextTurn
      
    end

    def combat
      
    end
    
    def combatGo (station, enemy)
      
    end

    def to_s
      puts "Número de medallas necesarias para ganar #{@@WIN}, 
      contador de turnos #{@turns}, Indice de la estación actual #{@currentStationIndex}"
      puts "\nEstación espacial actual "
      currentStation.to_s
      puts "\nNave enemiga actual" 
      currentEnemy.to_s
      
      puts "\nEstaciones espaciales en la partida: "
     
      for i in(0..(@spaceStations.lenght-1))
        @spaceStations[i].to_s
      end
      
    end

  end
end