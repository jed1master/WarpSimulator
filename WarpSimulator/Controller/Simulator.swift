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
    
    func getRandomPrize() -> String {
        
        var result = ""
        let fiveStarChance = 0.6
        let fourStarChance = 5.1
        let blueTrashChance = 94.3
        
        result = weightedRandom(weightedValues: ("legendary", fiveStarChance), ("epic", fourStarChance), ("blue", blueTrashChance))
        fiveStarCounter += 1
        fourStarCounter += 1
        print("5s warps is \(fiveStarCounter)")
        print("4s warps is \(fourStarCounter)")
        print("________________")
        
        if (fiveStarCounter == 90) && (fourStarCounter == 10) {
            result = "legendary"
            fiveStarCounter = 0
            fourStarCounter = 0
            return result
        }
        
        if result == "legendary" {
            result = "legendary"
            fiveStarCounter = 0
            return result
        }
        
        if result == "epic" {
            result = "epic"
            fourStarCounter = 0
            return result
        }
        
        if fiveStarCounter == 90 {
            result = "legendary"
            fiveStarCounter = 0
            return result
        }
        else if fourStarCounter == 10 {
            result = "epic"
            fourStarCounter = 0
            return result
        }
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
