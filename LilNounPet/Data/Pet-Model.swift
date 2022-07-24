//
//  Pet-Model.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import Foundation


struct Pet: Codable {
    var name: String
    var bio: String
    var birthday = Date()
    
    var lastMeal: Date
    var lastDrink: Date
    
    var body: String
    var accessory: String
    var head: String
    var glasses: String
    
    var age: Double {
        let timeSince = Double(calcTimeSince(date: birthday))
        //converts seconds into days
        let days = timeSince / 86400
        return days
    }
    
    var ageAtDeath: Double {
        let timeSinceBirth = Double(calcTimeSince(date: birthday))
        
        let timeSinceLastMeal = Double(calcTimeSince(date: lastMeal))
        let timeSinceLastDrink = Double(calcTimeSince(date: lastDrink))
        
        let birthToDeathByThirst = timeSinceBirth - (timeSinceLastDrink - 43200)
        let birthToDeathByHunger = timeSinceBirth - (timeSinceLastMeal - 86400)
        
        //see if thirst killed the pet first. If so, return that - else, return time it took to die of hunger
        if birthToDeathByThirst <= birthToDeathByHunger {
            //dividing by 86400 to convert into days
            return birthToDeathByThirst / 86400
        } else {
            return birthToDeathByHunger / 86400
        }
        
    }
    
    var isAlive: Bool {
        let timeSinceMeal = calcTimeSince(date: lastMeal)
        let timeSinceDrink = calcTimeSince(date: lastDrink)
        
        if timeSinceDrink > 43200 || timeSinceMeal > 86400 {
            return false
        } else {
            return true
        }
    }
    
    var isAwake: Bool {
        let calendar = Calendar.current
        let now = Date()
        
        let startOfToday = calendar.startOfDay(for: now)
        let bedTime = calendar.date(byAdding: .hour, value: 22, to: startOfToday)!
        let wakeTime = calendar.date(byAdding: .hour, value: 7, to: startOfToday)!
        
        let awakeTime =  wakeTime...bedTime
        
        if awakeTime.contains(now) {
            return true
        } else {
            return false
        }
        
    }

    var hunger: Int {
        let timeSince = calcTimeSince(date: lastMeal)
        var int = 0
        
        switch timeSince {
        case 0..<14400: int = 6
        case 14400..<28800: int = 5
        case 28800..<43200: int = 4
        case 43200..<57600: int = 3
        case 57600..<72000: int = 2
        case 72000...: int = 1
        default: int = 0
        }
        
        return int
    }
    
    var thirst: Int {
        let timeSince = calcTimeSince(date: lastDrink)
        var int = 0

        switch timeSince {
        case 0..<7200: int = 6
        case 7200..<14400: int = 5
        case 14400..<21600: int = 4
        case 21600..<28800: int = 3
        case 28800..<36000: int = 2
        case 36000...: int = 1
        default: int = 0
        }

        return int
    }
    
    var eyeExpression: String {
        if !isAlive {
            return "dead"
        } else if !isAwake {
            return "sleep"
        } else {
            return self.glasses
        }
    }
    
    var hungerExpression: String {
        if isAlive && isAwake {
            if hunger < 4 {
                return "hungry"
            }
            return ""
        }
       return ""
    }
    
    var thirstExpression: String {
        if isAlive && isAwake {
            if thirst < 4 {
                return "thirsty"
            }
            return ""
        }
       return ""
    }
    
    
}

