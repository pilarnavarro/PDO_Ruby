#encoding:utf-8
require_relative 'WeaponToUI'
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
    
    def getUIversion
      return WeaponToUI.new(self)
    end
    

    def to_s
      aux="\t\tNombre: #{name} \tTipo de arma:  #{type.to_s} \n\tNúmero de usos de que dispone: #{uses}\n\n"
      return aux
    end
  end
  
end