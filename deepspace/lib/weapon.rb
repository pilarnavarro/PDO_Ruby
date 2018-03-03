module Deepspace
  class Weapon
    attr_reader :name,:type,:uses

    def initialize(name,type,uses)
      @name=name  #String
      @type=type  #WeaponType
      @uses=uses  #int
    end

    def self.newCopy(copy)
      new(copy.name,copy.type,copy.uses)
    end

    def power
      type.power
    end

    def useIt
      if @uses>0
        @uses-=1
        power
      else 
        return 1.0
      end
    end

  end
  
end