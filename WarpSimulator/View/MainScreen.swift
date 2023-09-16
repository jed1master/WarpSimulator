//
//  MainScreen.swift
//  WarpSimulator
//
//  Created by Александр Корепанов on 05.09.2023.
//

import UIKit

class MainScreen: UIViewController {
    
    
    let backgroundImageView = UIImageView()
    let warpButton = UIButton()
    let x10WarpButton = UIButton()
    let simulator = Simulator()
    var square = CAShapeLayer()
    var squareNames: [CAShapeLayer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        configureBackgroundImageView()
//        setBackgroundImageViewConstraints()
        configureWarpButton()
        configureX10WarpButton()
        setX10WarpButtonConstraints()
        setWarpButtonConstraints()
    }
    
    


    func configureBackgroundImageView() {
        view.addSubview(backgroundImageView)
        
        backgroundImageView.image = UIImage(named: "images.jpeg")
        backgroundImageView.contentMode = .scaleToFill
        
    }
    
    func setBackgroundImageViewConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func configureWarpButton() {
        view.addSubview(warpButton)
        warpButton.configuration = .filled()
        warpButton.configuration?.cornerStyle = .capsule
        warpButton.configuration?.title = "x1 warp"
        warpButton.configuration?.background.strokeWidth = 2
        warpButton.configuration?.background.strokeColor = .black
        warpButton.configuration?.baseForegroundColor = .orange
        warpButton.configuration?.baseBackgroundColor = .white
        
        warpButton.addAction(UIAction { [weak self] _ in
            self?.hide10Xsquares()
            guard let result = self?.simulator.getRandomPrize() else {return}
//            self?.setBackgroundColour(warpResult: result)
            self?.didReceiveReward(result)
        }, for: .touchUpInside)
        
    }
    
    func setWarpButtonConstraints() {
        warpButton.translatesAutoresizingMaskIntoConstraints = false
        warpButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        warpButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        warpButton.trailingAnchor.constraint(equalTo: x10WarpButton.leadingAnchor, constant: -30).isActive = true
        warpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        
    }
    
    func configureX10WarpButton() {
        
        view.addSubview(x10WarpButton)
        x10WarpButton.configuration = .filled()
        x10WarpButton.configuration?.cornerStyle = .capsule
        x10WarpButton.configuration?.title = "x10 warp"
        x10WarpButton.configuration?.background.strokeWidth = 2
        x10WarpButton.configuration?.background.strokeColor = .black
        x10WarpButton.configuration?.baseForegroundColor = .orange
        x10WarpButton.configuration?.baseBackgroundColor = .white
        
        x10WarpButton.addAction(UIAction { [weak self] _ in
            self?.view.backgroundColor = .white
            guard let x10result = self?.simulator.x10Reward  else {return}
            self?.simulator.getX10RandomPrize(completion: { x10result in
                self?.drowX10squares(rewards: x10result)
            })
            
        }, for: .touchUpInside)
        
        
    }
    
    func setX10WarpButtonConstraints() {
        x10WarpButton.translatesAutoresizingMaskIntoConstraints = false
        x10WarpButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        x10WarpButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        x10WarpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        x10WarpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        
    }
    
    func drowSquare(squareName: String, rectX: Int, rectY: Int, color: UIColor) {
        let rect = CGRect(x: rectX, y: rectY, width: 110, height: 110)
        let squarePath = UIBezierPath(rect: rect)
        
        let squareName = CAShapeLayer()
        squareName.path = squarePath.cgPath
        squareName.fillColor = color.cgColor
        squareName.strokeColor = UIColor.black.cgColor
        squareName.lineWidth = 2
        view.layer.addSublayer(squareName)
        squareNames.append(squareName)
        
    }
    
    func drowX10squares(rewards: [Reward]) {
        
        var x = 110
        var y = 50
        var count = 0
        var name = "square"
        
        for reward in rewards {
            drowSquare(squareName: name , rectX: x, rectY: y, color: reward.color)
            x += 130
            count += 1
            name = "square" + "\(count)"
            if count == 5 {
                x = 110
                y = 180
            }
        }
        
    }
    
    func hide10Xsquares() {
        for name in squareNames {
            name.isHidden = true
        }
        squareNames = []
    }
    
    func didReceiveReward(_ reward: Reward) {
        view.backgroundColor = reward.color
    }
    
//    func setBackgroundColour(warpResult: String) {
//        switch warpResult {
//        case "legendary":
//            view.backgroundColor = UIColor(red: 255/255, green: 187/255, blue: 92/255, alpha: 255/255)
//
//        case "epic":
//            view.backgroundColor = UIColor(red: 128/255, green: 98/255, blue: 214/255, alpha: 255/255)
//        case "blue":
//            view.backgroundColor = UIColor(red: 39/255, green: 158/255, blue: 255/255, alpha: 255/255)
//        default:
//            view.backgroundColor = .white
//        }
//    }
    
}

