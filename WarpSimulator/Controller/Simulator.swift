//
//  Simulator.swift
//  WarpSimulator
//
//  Created by Александр Корепанов on 08.09.2023.
//

import Foundation
import UIKit

class Simulator {
    
    var fiveStarCounter = 0
    var fourStarCounter = 0
    
//    func getRandomPrize() -> String {
//
//        var result = ""
//        let fiveStarChance = 0.6
//        let fourStarChance = 5.1
//        let blueTrashChance = 94.3
//
//
//        result = weightedRandom(weightedValues: ("legendary", fiveStarChance), ("epic", fourStarChance), ("blue", blueTrashChance))
//        fiveStarCounter += 1
//        fourStarCounter += 1
//        print("5s warps is \(fiveStarCounter)")
//        print("4s warps is \(fourStarCounter)")
//        print("________________")
//
//        if (fiveStarCounter == 90) && (fourStarCounter == 10) {
//            result = "legendary"
//            fiveStarCounter = 0
//            fourStarCounter = 0
//            return result
//        }
//
//        if result == "legendary" {
//            result = "legendary"
//            fiveStarCounter = 0
//            return result
//        }
//
//        if result == "epic" {
//            result = "epic"
//            fourStarCounter = 0
//            return result
//        }
//
//        if fiveStarCounter == 90 {
//            result = "legendary"
//            fiveStarCounter = 0
//            return result
//        }
//        else if fourStarCounter == 10 {
//            result = "epic"
//            fourStarCounter = 0
//            return result
//        }
//        return result
//
//    }
    
    var warps: Int = 0
    
    private var legendaries: Int = 0
    private var epics: Int = 0
    
    func getRandomPrize() -> Reward {
        
        let result: Reward
        
        warps += 1
        
//        fiveStarCounter += 1
//        fourStarCounter += 1
        
        let legendaryGuaranty = (legendaries + 1).isMultiple(of: 90)
        let epicGuaranty = (epics + 1).isMultiple(of: 10)
        
        
        switch (legendaryGuaranty,epicGuaranty) {
        case (true,true):
            result = .legendary
            legendaries = 0
            epics = 0
            print("Epic x Legendary ***")
            
        case (true,false):
            result = .legendary
            legendaries = 0
            epics += 1
            print("Legendary ***")
            
        case (false,true):
            result = .epic
            epics = 0
            legendaries += 1
            print("Epic ***")
            
        case (false,false):
            
            var legendaryBonus: Double = 0
            if legendaries >= 75 {
                legendaryBonus = 20 - Reward.legendary.dropChance
                print("Chance (legendary):", Reward.legendary.dropChance + legendaryBonus)
                print("Chance (epic):", Reward.epic.dropChance)
                print("Chance (common):", Reward.common.dropChance - legendaryBonus)
            }
            
            result = weightedRandom(weightedValues: (.legendary, Reward.legendary.dropChance + legendaryBonus), (.epic, Reward.epic.dropChance), (.common, Reward.common.dropChance - legendaryBonus))
            
            switch result {
            case .legendary:
                legendaries = 0
                epics += 1

            case .epic:
                legendaries += 1
                epics = 0
                
            case .common:
                legendaries += 1
                epics += 1
            }
        }
        
        
        
        print("Warp:", warps)
        
        print("5s warps:", legendaries)
        print("4s warps:", epics)
        
        print("________________")
        print()
        
        return result
        
    }
    
    func weightedRandom<Value>(weightedValues: (value: Value, weight: Double)...) -> Value {
        let rnd = Double.random(in: 0.0...100.0)
    //    let rnd = 0.6
        var accWeight = 0.0
        print(rnd)
        for (value, weight) in weightedValues {
            accWeight += weight
//            print(rnd, accWeight)
            if rnd <= accWeight {
                return value
            }
        }
        //If the sum of weights is less the 100%, the last value is returned
        return weightedValues.last!.value
    }
    
}
