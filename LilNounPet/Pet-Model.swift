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
                if hunger == "♥︎♡♡♡♡♡" || hunger == "♥︎♥︎♡♡♡♡" || hunger == "♥︎♥︎♥︎♡♡♡" {
                    return "hungry"
                }
        return ""
    }
    
//    var mouthExpression: String {
//
//        if hunger == "♥︎♡♡♡♡♡" || thirst == "♥︎♡♡♡♡♡" {
//            return "sad"
//        }
//
//        if hunger == "♥︎♥︎♡♡♡♡" || thirst == "♥︎♥︎♡♡♡♡" {
//            return "zzz"
//        }
//
//        if hunger == "♥︎♥︎♥︎♥︎♡♡" || thirst == "♥︎♥︎♥︎♥︎♡♡" ||
//            hunger == "♥︎♥︎♥︎♡♡♡" || thirst == "♥︎♥︎♥︎♡♡♡" {
//            return "basic"
//        }
//
//        if hunger == "♥︎♥︎♥︎♥︎♥︎♡" || thirst == "♥︎♥︎♥︎♥︎♥︎♡" {
//            return "tongue-out"
//        }
//
//        if hunger == "♥︎♥︎♥︎♥︎♥︎♥︎" || thirst == "♥︎♥︎♥︎♥︎♥︎♥︎" {
//            return "happy"
//        }
//
//        return ""
//    }
    
    var hunger: String {
        let timeSince = calcTimeSince(date: lastMeal)
        var string = ""
        
        switch timeSince {
        case 0..<14400: string = "♥︎♥︎♥︎♥︎♥︎♥︎"
        case 14400..<28800: string = "♥︎♥︎♥︎♥︎♥︎♡"
        case 28800..<43200: string = "♥︎♥︎♥︎♥︎♡♡"
        case 43200..<57600: string = "♥︎♥︎♥︎♡♡♡"
        case 57600..<72000: string = "♥︎♥︎♡♡♡♡"
        case 72000...: string = "♥︎♡♡♡♡♡"
        default: string = ""
        }
        
        return string
    }
    
    var thirst: String {
        let timeSince = calcTimeSince(date: lastDrink)
        var string = ""
        
        switch timeSince {
        case 0..<7200: string = "♥︎♥︎♥︎♥︎♥︎♥︎"
        case 7200..<14400: string = "♥︎♥︎♥︎♥︎♥︎♡"
        case 14400..<21600: string = "♥︎♥︎♥︎♥︎♡♡"
        case 21600..<28800: string = "♥︎♥︎♥︎♡♡♡"
        case 28800..<36000: string = "♥︎♥︎♡♡♡♡"
        case 36000...: string = "♥︎♡♡♡♡♡"
        default: string = ""
        }
        
        return string
    }
}

