# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'GameUniverseToUI'
require_relative 'GameStateController'
require_relative 'Dice'
require_relative 'CardDealer'
require_relative 'SpaceStation'
require_relative 'CombatResult'

module Deepspace
  class GameUniverse
    attr_reader :turns, :dice, :spaceStations, :currentStation, :currentEnemy, :currentStationIndex
    @@WIN=10
    def initialize
      @turns=0;
      @gameState=GameStateController.new
      @dice=Dice.new()
    end
    
    def haveAWinner     
      if(@currentStation.nMedals>=@@WIN)
        return true
      end
      return false
    end
    
    def getUIversion
      return GameUniverseToUI.new(currentStation, currentEnemy)
    end
    
    def state
      @gameState.state
    end
    
    def discardShieldBooster(i)
      if(state==GameState::INIT || state==GameState::AFTERCOMBAT)
            @currentStation.discardShieldBooster(i);
      end
    end
    
    def discardHangar
      if(state==GameState::INIT || state==GameState::AFTERCOMBAT)
            @currentStation.discardHangar;
      end
    end

    def discardShieldBoosterInHangar(i)
      if(state==GameState::INIT || state==GameState::AFTERCOMBAT)
            @currentStation.discardShieldBoosterInHangar(i);
      end
    end
    
    def discardWeapon(i)
      if(state==GameState::INIT || state==GameState::AFTERCOMBAT)
            @currentStation.discardWeapon(i);
      end
    end
    
    def discardWeaponInHangar(i)
      if(state==GameState::INIT || state==GameState::AFTERCOMBAT)
            @currentStation.discardWeaponInHangar(i);
      end
    end
    
    def mountShieldBooster(i)
      if(state==GameState::INIT || state==GameState::AFTERCOMBAT)
            @currentStation.mountShieldBooster(i);
      end
    end
    
    def mountWeapon(i)
      if(state==GameState::INIT || state==GameState::AFTERCOMBAT)
            @currentStation.mountWeapon(i);
      end
    end
    
    def init(names)
      state=@gameState.state
        
      if state==GameState::CANNOTPLAY
        @spaceStations=Array.new  #Vector de SpaceStation
        dealer=CardDealer.instance
        
        for i in(0...names.length)
          supplies=dealer.nextSuppliesPackage
          station=SpaceStation.new(names[i],supplies)  #¿name[i],no estoy segura? Sí, silvia
          nh=dice.initWithNHangars
          nw=dice.initWithNWeapons
          ns=dice.initWithNShields
          l=Loot.new(0,nw,ns,nh,0)
          station.setLoot(l)
          @spaceStations.push(station)
        end
        
        @currentStationIndex=dice.whoStarts(names.length)  
        @currentStation=spaceStations[@currentStationIndex]
        @currentEnemy=dealer.nextEnemy
        @gameState.next(turns,@spaceStations.length)
      end
    end
  
    def nextTurn
      gamestate=@gameState.state
      
      if gamestate==GameState::AFTERCOMBAT
        stationState=currentStation.validState
        if(stationState)
          @currentStationIndex=(currentStationIndex+1)%spaceStations.length
          @turns+=1
          @currentStation=@spaceStations[@currentStationIndex]
          @currentStation.cleanUpMountedItems
          dealer=CardDealer.instance
          @currentEnemy=dealer.nextEnemy
          @gameState.next(turns,spaceStations.length)
          return true
        end
        return false
      end
      return false
    end

    def combat
      state=@gameState.state
      if (state==GameState::BEFORECOMBAT) || (state==GameState::INIT)
        return combatGo(@currentStation, @currentEnemy);
      end
    return CombatResult::NOCOMBAT;
    end
    
    def combatGo(station,enemy)
        ch=@dice.firstShot
        if ch==GameCharacter::ENEMYSTARSHIP
          fire=enemy.fire
          result=station.receiveShot(fire)
          if result==ShotResult::RESIST
            fire1=station.fire
            result1=enemy.receiveShot(fire1)
            enemyWins=(result1==ShotResult::RESIST)
          else
            enemyWins=true
          end
        else
          fire=station.fire
          result=enemy.receiveShot(fire)
          enemyWins=(result==ShotResult::RESIST)
        end
        
        if enemyWins
          s=station.getSpeed
          moves=@dice.spaceStationMoves(s)
          
          if !moves
            damage=enemy.damage
            station.setPendingDamage(damage)
            combatResult=CombatResult::ENEMYWINS
          else
            station.move
            combatResult=CombatResult::STATIONESCAPES
          end
        else
          aLoot=enemy.loot
          station.setLoot(aLoot)
          combatResult=CombatResult::STATIONWINS
        end
        @gameState.next(turns,spaceStations.length)
        
        return combatResult
     end

    private :combatGo
  end
end