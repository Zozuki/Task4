//
//  main.swift
//  Task4
//
//  Created by user on 15.03.2021.
//

import Foundation

enum colours: String {
    case blue = "синий"
    case black = "черный"
    case green = "зеленый"
    case purple = "фиолетовый"
    case yellow = "желтый"
}

enum wheels: String {
    case standart = "стандарт"
    case medium = "представительский"
    case premium = "премиум"
}

enum brand {
    case Honda, Shevrolet, Nissan, Lada, Wolksvagen, Mersedes, BMW
}

enum condition: String {
    case new = "только из салона"
    case used = "Б/У"
}

enum spoilers: String {
    case mini = "небольшой"
    case medium = "средний"
    case large = "большой"
}

enum size: Double {
    case min = 20
    case medium = 30
    case large = 45
}

//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.

enum actions {
    
    case fillTheTank(volume: Double)
    case changeSpoilerSize(size: spoilers)
    case changeSpoilerColour(colour: colours)
    case changeTrunkSize(size: size)
    case unloadTrunk(volume: Double)
    case loadTrunk(volume: Double)
    case printInfo
    
}

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.

class Car {
    
    var brand: brand
    var carColour: colours
    var wheels: wheels
    var condition: condition
    var tankVolume: Double
    var tankFilledVolume: Double
    
    init(brand: brand, carColour: colours, wheels: wheels, condition: condition, tankVolume: Double, tankFilledVolume: Double) {
        
        self.brand = brand
        self.carColour = carColour
        self.wheels = wheels
        self.condition = condition
        self.tankVolume = tankVolume
        self.tankFilledVolume = tankFilledVolume
    }
    
    func action(action: actions) {
        
    }
    
}

//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.

class SportCar: Car {
    
    var spoiler: spoilers
    var spoilerColour: colours
  
    
    init(brand: brand, carColour: colours, wheels: wheels, condition: condition, tankVolume: Double, tankFilledVolume: Double, spoiler: spoilers, spoilerColour: colours) {
        
        self.spoiler = spoiler
        self.spoilerColour = spoilerColour
        
        
        super.init(brand: brand, carColour: carColour, wheels: wheels, condition: condition, tankVolume: tankVolume, tankFilledVolume: tankFilledVolume)
        
    }
    
//  4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
    
    override func action(action: actions) {
        
        switch action {
        
        case .fillTheTank(let volume):
            if tankFilledVolume + volume > tankVolume {
                print("Бак полон! Но все в него не влезло, объем оставшегося горючего равен: \(tankFilledVolume + volume - tankVolume)")
                tankFilledVolume = tankVolume
            } else {
                tankFilledVolume += volume
                print("Бак был заправлен на \(volume) л. Объем бака заполненен на \(tankFilledVolume) из \(tankVolume)")
            }
        case .changeSpoilerSize(let size):
            self.spoiler  = size
            print("Теперь размер вашего спойлера: \(size.rawValue)")
        case .changeSpoilerColour(let colour):
            self.spoilerColour = colour
            print("Теперь у вас \(colour.rawValue) спойлер")
            if colour == carColour {
                print("Он отлично сочетается с цветом вашей машины!")
            }
        case .printInfo:
            print("\n У вас спортивный автомобиль марки: \(brand)\n Цвет: \(carColour.rawValue)\n Колеса класса: \(wheels.rawValue) \n Cостояние: \(condition.rawValue) \n Объем бака: \(tankVolume) \n Заполненный объем бака: \(tankFilledVolume) \n Размер спойлера: \(spoiler.rawValue) \n Цвет спойлера: \(spoilerColour.rawValue) \n  ")
        default:
            print("Это действие недоступно для вашего транспорта")
        
        }
   
    }

}

//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.

class TrunkCar: Car {
    
    var trunkSize: size
    var trunkFilledSize: Double
    
    init(brand: brand, carColour: colours, wheels: wheels, condition: condition, tankVolume: Double, tankFilledVolume: Double, trunkSize: size, trunkFilledSize: Double) {
        
        self.trunkSize = trunkSize
        self.trunkFilledSize = trunkFilledSize
        super.init(brand: brand, carColour: carColour, wheels: wheels, condition: condition, tankVolume: tankVolume, tankFilledVolume: tankFilledVolume)
        
    }
    
//  4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
    
    override func action(action: actions) {
        
        switch action {
        
        case .changeTrunkSize(let size):
            self.trunkSize = size
            print("Теперь объем вашего кузова составляет \(size.rawValue) литров")
        case .loadTrunk(let volume):
            if trunkSize.rawValue < trunkFilledSize + volume {
                print("Кузов забит под завязку! В него не поместилось: \(trunkFilledSize + volume - trunkSize.rawValue )")
                trunkFilledSize = trunkSize.rawValue
            } else {
                trunkFilledSize += volume
                print("Вы загрузили в кузов \(volume). Теперь в кузове:  \(trunkFilledSize)")
            }
        case .unloadTrunk(let volume):
            if trunkFilledSize - volume < 0 {
                trunkFilledSize = 0
                print("Вы выгрузили все, что было! Но хотели выгрузить еще больше...")
            } else {
                trunkFilledSize -= volume
                print("Вы выгрузили из кузова \(volume). В кузове осталось: \(trunkFilledSize)")
            }
        case .printInfo:
            print("\n У вас грузоваой автомобиль марки: \(brand)\n Цвет: \(carColour.rawValue)\n Колеса класса: \(wheels.rawValue) \n Cостояние: \(condition.rawValue) \n Объем бака: \(tankVolume) \n Заполненный объем бака: \(tankFilledVolume) \n Объем кузова: \(trunkSize.rawValue) \n Заполненный объем кузова: \(trunkFilledSize) \n  ")
        default:
            print("Это действие недоступно для вашего транспорта ")
       
        }
   
    }

}

//5. Создать несколько объектов каждого класса. Применить к ним различные действия.

var car1 = SportCar(brand: .Nissan, carColour: .black, wheels: .premium, condition: .new, tankVolume: 30, tankFilledVolume: 0, spoiler: .large, spoilerColour: .blue)

car1.action(action: .fillTheTank(volume: 12))
car1.action(action: .fillTheTank(volume: 10))
car1.action(action: .changeSpoilerColour(colour: .black))
car1.action(action: .changeSpoilerSize(size: .medium))
car1.action(action: .changeTrunkSize(size: .large))

var trunk1 = TrunkCar(brand: .Wolksvagen, carColour: .blue, wheels: .standart, condition: .new, tankVolume: 40, tankFilledVolume: 0, trunkSize: .large, trunkFilledSize: 0)

trunk1.action(action: .changeTrunkSize(size: .medium))
trunk1.action(action: .loadTrunk(volume: 20))
trunk1.action(action: .unloadTrunk(volume: 30))
trunk1.action(action: .loadTrunk(volume: 45))

//6. Вывести значения свойств экземпляров в консоль.

car1.action(action: .printInfo)
trunk1.action(action: .printInfo)
