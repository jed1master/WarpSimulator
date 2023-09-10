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
    let simulator = Simulator()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        configureBackgroundImageView()
//        setBackgroundImageViewConstraints()
        configureWarpButton()
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
        warpButton.configuration?.title = "warp"
        warpButton.configuration?.background.strokeWidth = 2
        warpButton.configuration?.background.strokeColor = .black
        warpButton.configuration?.baseForegroundColor = .orange
        warpButton.configuration?.baseBackgroundColor = .white
        
        warpButton.addAction(UIAction { [weak self] _ in
            guard let result = self?.simulator.getRandomPrize() else {return}
            self?.setBackgroundColour(warpResult: result)
            
        }, for: .touchUpInside)
        
    }
    
    func setWarpButtonConstraints() {
        warpButton.translatesAutoresizingMaskIntoConstraints = false
        warpButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        warpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        warpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        warpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        
    }
    
    func setBackgroundColour(warpResult: String) {
        switch warpResult {
        case "legendary":
            view.backgroundColor = UIColor(red: 255/255, green: 187/255, blue: 92/255, alpha: 255/255)
        
        case "epic":
            view.backgroundColor = UIColor(red: 128/255, green: 98/255, blue: 214/255, alpha: 255/255)
        case "blue":
            view.backgroundColor = UIColor(red: 39/255, green: 158/255, blue: 255/255, alpha: 255/255)
        default:
            view.backgroundColor = .white
        }
    }
    
}

