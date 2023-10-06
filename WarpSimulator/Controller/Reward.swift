//
//  Reward.swift
//  WarpSimulator
//
//  Created by Oleh Korchytskyi on 12.09.2023.
//

import Foundation
import UIKit

enum Reward {
    case legendary
    case epic
    case common
}

extension Reward {
    var dropChance: Double {
        switch self {
        case .legendary:
            return 0.6
        case .epic:
            return 5.1
        case .common:
            return 94.3
        }
    }
    
    var title: String {
        switch self {
        case .legendary:
            return "Legendary"
        case .epic:
            return "Epic"
        case .common:
            return "Common"
        }
    }
    
//    var color: UIColor {
//        switch self {
//        case .legendary:
//            return UIColor(red: 255/255, green: 187/255, blue: 92/255, alpha: 255/255)
//        case .epic:
//            return UIColor(red: 128/255, green: 98/255, blue: 214/255, alpha: 255/255)
//        case .common:
//            return UIColor(red: 39/255, green: 158/255, blue: 255/255, alpha: 255/255)
//        }
//    }
}

