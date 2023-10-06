//
//  MainScreen.swift
//  WarpSimulator
//
//  Created by Александр Корепанов on 05.09.2023.
//

import UIKit

class MainScreen: UIViewController {
    
    let backgroundImageView = UIImageView()
    let resultImageView = UIImageView()
    let warpButton = UIButton()
    let x10WarpButton = UIButton()
    let closeButton = UIButton()
    let simulator = Simulator()
    var square = CAShapeLayer()
    var squareNames: [CAShapeLayer] = []
    var commonPictures: [String] = []
    var epicPictures: [String] = []
    var legendaryPictures: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundImageView()
        setBackgroundImageViewConstraints()
        configureResultImageView()
        setResultImageViewConstraints()
        configureWarpButton()
        configureX10WarpButton()
        setX10WarpButtonConstraints()
        setWarpButtonConstraints()
        configureCloseButton()
        setCloseButtonConstraints()
        getPicturesFromAssets()
    }
    
    func configureBackgroundImageView() {
        view.addSubview(backgroundImageView)
        
        backgroundImageView.image = UIImage(named: "stars.jpeg")
        backgroundImageView.contentMode = .scaleToFill
    }
    
    func setBackgroundImageViewConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureResultImageView() {
        view.addSubview(resultImageView)
        
        resultImageView.isHidden = true
        resultImageView.contentMode = .scaleAspectFit
//        backgroundImageView.bringSubviewToFront(resultImageView)
    }
    
    func setResultImageViewConstraints() {
        resultImageView.translatesAutoresizingMaskIntoConstraints = false
        
        resultImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        resultImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        resultImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        resultImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
    func configureWarpButton() {
        view.addSubview(warpButton)
        
        warpButton.configuration = .filled()
        warpButton.configuration?.cornerStyle = .capsule
        warpButton.configuration?.title = "x1 warp"
        warpButton.configuration?.background.strokeWidth = 2
        warpButton.configuration?.background.strokeColor = .black
        warpButton.configuration?.baseForegroundColor = .black
        warpButton.configuration?.baseBackgroundColor = .white
        
        warpButton.addAction(UIAction { [weak self] _ in
            self?.remove10Xsquares()
            self?.hideButtons()
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
        x10WarpButton.configuration?.baseForegroundColor = .black
        x10WarpButton.configuration?.baseBackgroundColor = .white
        
        x10WarpButton.addAction(UIAction { [weak self] _ in
            self?.view.backgroundColor = .white
            guard (self?.simulator.x10Reward) != nil  else {return}
            self?.remove10Xsquares()
            self?.simulator.getX10RandomPrize(completion: { x10result in
//                self?.drowX10squares(rewards: x10result)
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
    
    func configureCloseButton() {
        view.addSubview(closeButton)
        
        closeButton.isHidden = true
        closeButton.configuration = .plain()
//        closeButton.configuration?.buttonSize = .small
//        closeButton.configuration?.image = UIImage(resource: .close)
//        closeButton.configuration?.contentInsets = .zero
        let image = UIImage(systemName: "xmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        closeButton.configuration?.image = image
       
        
        
        closeButton.addAction(UIAction { [weak self] _ in
            self?.resultImageView.isHidden = true
            self?.showButtons()
        }, for: .touchUpInside)
    }
    
    func setCloseButtonConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 25).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
//        closeButton.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: -10).isActive = true
//        closeButton.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: 20).isActive = true
        
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
    
//    func drowX10squares(rewards: [Reward]) {
//        
//        var x = 110
//        var y = 50
//        var count = 0
//        var name = "square"
//        
//        for reward in rewards {
//            drowSquare(squareName: name , rectX: x, rectY: y, color: reward.color)
//            x += 130
//            count += 1
//            name = "square" + "\(count)"
//            if count == 5 {
//                x = 110
//                y = 180
//            }
//        }
//        
//    }
    
    func remove10Xsquares() {
        for name in squareNames {
            name.removeFromSuperlayer()
        }
        squareNames = []
    }
    
    func hideButtons() {
        closeButton.isHidden = false
        warpButton.isHidden = true
        x10WarpButton.isHidden = true
    }
    
    func showButtons() {
        closeButton.isHidden = true
        warpButton.isHidden = false
        x10WarpButton.isHidden = false
    }
    func getPicturesFromAssets() {
        
        getLegendaryPictures()
        getEpicPictures()
        getCommonPictures()
        
        func getLegendaryPictures() {
            var count = 1
            for _ in 0...13 {
                legendaryPictures.append("5star" + "\(count)")
                count += 1
            }
        }
        
        func getEpicPictures() {
            var count = 1
            for _ in 0...49 {
                epicPictures.append("4star" + "\(count)")
                count += 1
            }
        }
        
        func getCommonPictures() {
            var count = 1
            for _ in 0...20 {
                commonPictures.append("3star" + "\(count)")
                count += 1
            }
        }
    }
    
    func didReceiveReward(_ reward: Reward) {
        
        switch reward.title {
            
        case "Legendary" :
            let randomNumber = Int.random(in: 0...13)
            resultImageView.image = UIImage(named: legendaryPictures[randomNumber])
            resultImageView.isHidden = false
            
        case "Epic" :
            let randomNumber = Int.random(in: 0...49)
            resultImageView.image = UIImage(named: epicPictures[randomNumber])
            resultImageView.isHidden = false
            
        case "Common" :
            let randomNumber = Int.random(in: 0...20)
            resultImageView.image = UIImage(named: commonPictures[randomNumber])
            resultImageView.isHidden = false
       
        default :
            resultImageView.image = UIImage(resource: .stars)
            resultImageView.isHidden = false
        }
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

