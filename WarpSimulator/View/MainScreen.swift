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
    let scrollView = UIScrollView()
    let horizontalStackview = UIStackView()
    let verticalFirstStackView = UIStackView()
    let verticalSecondStackView = UIStackView()
    let warpButton = UIButton()
    let x10WarpButton = UIButton()
    let closeButton = UIButton()
    var x10ImageViews: [UIImageView] = []
    var x10Images: [UIImage] = []
    let simulator = Simulator()
    var square = CAShapeLayer()
    var squareNames: [CAShapeLayer] = []
    var commonPictures: [UIImage] = []
    var epicHeroPictures: [UIImage] = []
    var epicConePictures: [UIImage] = []
    var legendaryHeroPictures: [UIImage] = []
    var legendaryConePictures: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPicturesFromAssets()
        configureBackgroundImageView()
        setBackgroundImageViewConstraints()
        configureResultImageView()
        setResultImageViewConstraints()
        configureScrollView()
        setScrollViewConstraints()
        configureStackView()
        createAndAppendx10ImageViews()
        configureWarpButton()
        configureX10WarpButton()
        setX10WarpButtonConstraints()
        setWarpButtonConstraints()
        configureCloseButton()
        setCloseButtonConstraints()
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
        //        backgroundImageView.bringSubviewToFront(resultImageView)
    }
    
    func setResultImageViewConstraints() {
        resultImageView.translatesAutoresizingMaskIntoConstraints = false
        
        resultImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        resultImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        resultImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        resultImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
    }
    
    func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureStackView() {
        
        //setup horizontalStackview
        scrollView.addSubview(horizontalStackview)
        scrollView.isHidden = true
        horizontalStackview.distribution = .fillEqually
        horizontalStackview.axis = .horizontal
        horizontalStackview.spacing = 0
        
        //set horizontalStackview constaints
        
        horizontalStackview.translatesAutoresizingMaskIntoConstraints = false
        
        let hConst = horizontalStackview.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        horizontalStackview.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        horizontalStackview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        horizontalStackview.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        horizontalStackview.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        horizontalStackview.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        //setup verticalFirstStackView
        
        horizontalStackview.addArrangedSubview(verticalFirstStackView)
        
        verticalFirstStackView.axis = .vertical
        verticalFirstStackView.alignment = .center
        verticalFirstStackView.distribution = .fillEqually
        verticalFirstStackView.spacing = 20
        verticalFirstStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //setup verticalSecondStackView
        
        horizontalStackview.addArrangedSubview(verticalSecondStackView)
        
        verticalSecondStackView.axis = .vertical
        verticalSecondStackView.alignment = .center
        verticalSecondStackView.distribution = .fillEqually
        verticalSecondStackView.spacing = 20
        verticalSecondStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //        //create and setup 10 imageViews for pictures
        //
        //        let imageView1 = UIImageView()
        //        verticalFirstStackView.addArrangedSubview(imageView1)
        //        imageView1.image = UIImage(resource: ._3Star21)
        //        imageView1.contentMode = .scaleAspectFit
        //
        //        imageView1.widthAnchor.constraint(equalTo: verticalFirstStackView.widthAnchor).isActive = true
        //        imageView1.heightAnchor.constraint(equalToConstant: 370).isActive = true
        //
        //        x10ImageViews.append(imageView1)
        //
        //        let imageView2 = UIImageView()
        //        verticalFirstStackView.addArrangedSubview(imageView2)
        //        imageView2.image = UIImage(resource: ._4SHero1)
        //        imageView2.contentMode = .scaleAspectFit
        //
        //        imageView2.widthAnchor.constraint(equalTo: verticalFirstStackView.widthAnchor).isActive = true
        //        imageView2.heightAnchor.constraint(equalToConstant: 370).isActive = true
        //
        //        x10ImageViews.append(imageView2)
        //
        //        let imageView3 = UIImageView()
        //        verticalFirstStackView.addArrangedSubview(imageView3)
        //        imageView3.image = UIImage(resource: ._3Star21)
        //        imageView3.contentMode = .scaleAspectFit
        //
        //        imageView3.widthAnchor.constraint(equalTo: verticalFirstStackView.widthAnchor).isActive = true
        //        imageView3.heightAnchor.constraint(equalToConstant: 370).isActive = true
        //
        //        x10ImageViews.append(imageView3)
        //
        //        let imageView4 = UIImageView()
        //        verticalFirstStackView.addArrangedSubview(imageView4)
        //        imageView4.image = UIImage(resource: ._3Star21)
        //        imageView4.contentMode = .scaleAspectFit
        //
        //        imageView4.widthAnchor.constraint(equalTo: verticalFirstStackView.widthAnchor).isActive = true
        //        imageView4.heightAnchor.constraint(equalToConstant: 370).isActive = true
        //
        //        x10ImageViews.append(imageView4)
        //
        //        let imageView5 = UIImageView()
        //        verticalFirstStackView.addArrangedSubview(imageView5)
        //        imageView5.image = UIImage(resource: ._3Star21)
        //        imageView5.contentMode = .scaleAspectFit
        //
        //        imageView5.widthAnchor.constraint(equalTo: verticalFirstStackView.widthAnchor).isActive = true
        //        imageView5.heightAnchor.constraint(equalToConstant: 370).isActive = true
        //
        //        x10ImageViews.append(imageView5)
        //
        //        let imageView6 = UIImageView()
        //        verticalSecondStackView.addArrangedSubview(imageView6)
        //        imageView6.image = UIImage(resource: ._3Star21)
        //        imageView6.contentMode = .scaleAspectFit
        //
        //        imageView6.widthAnchor.constraint(equalTo: verticalSecondStackView.widthAnchor).isActive = true
        //        imageView6.heightAnchor.constraint(equalToConstant: 370).isActive = true
        //
        //        x10ImageViews.append(imageView6)
        //
        //        let imageView7 = UIImageView()
        //        verticalSecondStackView.addArrangedSubview(imageView7)
        //        imageView7.image = UIImage(resource: ._3Star21)
        //        imageView7.contentMode = .scaleAspectFit
        //
        //        imageView7.widthAnchor.constraint(equalTo: verticalSecondStackView.widthAnchor).isActive = true
        //        imageView7.heightAnchor.constraint(equalToConstant: 370).isActive = true
        //
        //        x10ImageViews.append(imageView7)
        //
        //        let imageView8 = UIImageView()
        //        verticalSecondStackView.addArrangedSubview(imageView8)
        //        imageView8.image = UIImage(resource: ._3Star21)
        //        imageView8.contentMode = .scaleAspectFit
        //
        //        imageView8.widthAnchor.constraint(equalTo: verticalSecondStackView.widthAnchor).isActive = true
        //        imageView8.heightAnchor.constraint(equalToConstant: 370).isActive = true
        //
        //        x10ImageViews.append(imageView8)
        //
        //        let imageView9 = UIImageView()
        //        verticalSecondStackView.addArrangedSubview(imageView9)
        //        imageView9.image = UIImage(resource: ._3Star21)
        //        imageView9.contentMode = .scaleAspectFit
        //
        //        imageView9.widthAnchor.constraint(equalTo: verticalSecondStackView.widthAnchor).isActive = true
        //        imageView9.heightAnchor.constraint(equalToConstant: 370).isActive = true
        //
        //        x10ImageViews.append(imageView9)
        //
        //        let imageView10 = UIImageView()
        //        verticalSecondStackView.addArrangedSubview(imageView10)
        //        imageView10.image = UIImage(resource: ._3Star21)
        //        imageView10.contentMode = .scaleAspectFit
        //
        //        imageView6.widthAnchor.constraint(equalTo: verticalSecondStackView.widthAnchor).isActive = true
        //        imageView6.heightAnchor.constraint(equalToConstant: 370).isActive = true
        //
        //        x10ImageViews.append(imageView10)
        
        
    }
    
    func createAndAppendx10ImageViews() {
        let name = "ImageView"
        var count = 1
        _ = name + "\(count)"
        for _ in 0...9 {
            
            if count > 5 {
                let ImageViewName = UIImageView()
                verticalSecondStackView.addArrangedSubview(ImageViewName)
                ImageViewName.contentMode = .scaleAspectFit
                ImageViewName.widthAnchor.constraint(equalTo: verticalSecondStackView.widthAnchor).isActive = true
                ImageViewName.heightAnchor.constraint(equalToConstant: 370).isActive = true
                x10ImageViews.append(ImageViewName)
                count += 1
            } else {
                let ImageViewName = UIImageView()
                verticalFirstStackView.addArrangedSubview(ImageViewName)
                ImageViewName.contentMode = .scaleAspectFit
                ImageViewName.widthAnchor.constraint(equalTo: verticalFirstStackView.widthAnchor).isActive = true
                ImageViewName.heightAnchor.constraint(equalToConstant: 370).isActive = true
                x10ImageViews.append(ImageViewName)
                count += 1
            }
        }
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
            self?.hideButtons()
            self?.scrollView.isHidden = true
            if let prize = self?.simulator.getRandomPrize() {
                
                let picture = self?.didReceiveReward(prize)
                if let image = picture,
                   let legendaryHeroImages = self?.legendaryHeroPictures,
                   let epicHeroImages = self?.epicHeroPictures {
                    self?.resultImageView.image = picture
                    self?.resultImageView.isHidden = false
                    if legendaryHeroImages.contains(where: {$0 == image}) ||
                        epicHeroImages.contains(where: {$0 == image}) {
                        self?.resultImageView.contentMode = .scaleAspectFill
                    } else {
                        self?.resultImageView.contentMode = .scaleAspectFit
                    }
                }
            }
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
            self?.hideButtons()
            self?.resultImageView.isHidden = true
            guard (self?.simulator.x10Reward) != nil else {return}
            self?.simulator.getX10RandomPrize(completion: { rewards in
                let images = self?.getImagesFromX10Rewards(rewards: rewards)
                if let pictures = images,
                   let imageViews = self?.x10ImageViews {
                    self?.setImagesForX10ImageViews(images: pictures, imageViews: imageViews)
                    self?.scrollView.isHidden = false
                }
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
            self?.scrollView.isHidden = true
            self?.x10Images = []
            self?.scrollView.contentOffset = .zero
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
    
    //    func drowSquare(squareName: String, rectX: Int, rectY: Int, color: UIColor) {
    //        let rect = CGRect(x: rectX, y: rectY, width: 110, height: 110)
    //        let squarePath = UIBezierPath(rect: rect)
    //
    //        let squareName = CAShapeLayer()
    //        squareName.path = squarePath.cgPath
    //        squareName.fillColor = color.cgColor
    //        squareName.strokeColor = UIColor.black.cgColor
    //        squareName.lineWidth = 2
    //        view.layer.addSublayer(squareName)
    //        squareNames.append(squareName)
    //    }
    
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
    
    //    func remove10Xsquares() {
    //        for name in squareNames {
    //            name.removeFromSuperlayer()
    //        }
    //        squareNames = []
    //    }
    
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
        
        getLegendaryHeroPictures()
        getLegendaryConePictures()
        getEpicHeroPictures()
        getEpicConePictures()
        getCommonPictures()
        
        func getLegendaryHeroPictures() {
            var count = 1
            for _ in 0...6 {
                if let image = UIImage(named: "5sHero" + "\(count)") {
                    legendaryHeroPictures.append(image)
                    count += 1
                }
            }
        }
        
        func getLegendaryConePictures() {
            var count = 1
            for _ in 0...6 {
                if let image = UIImage(named: "5sCone" + "\(count)") {
                    legendaryConePictures.append(image)
                    count += 1
                }
            }
        }
        
        func getEpicHeroPictures() {
            var count = 1
            for _ in 0...13 {
                if let image = UIImage(named: "4sHero" + "\(count)") {
                    epicHeroPictures.append(image)
                    count += 1
                }
            }
        }
        
        func getEpicConePictures() {
            var count = 1
            for _ in 0...35 {
                if let image = UIImage(named: "4sCone" + "\(count)") {
                    epicConePictures.append(image)
                    count += 1
                }
            }
        }
        
        func getCommonPictures() {
            var count = 1
            for _ in 0...20 {
                if let image = UIImage(named: "3star" + "\(count)") {
                    commonPictures.append(image)
                    count += 1
                }
            }
        }
    }
    
    func didReceiveReward(_ reward: Reward) -> UIImage {
        
        switch reward.title {
            
        case "Legendary" :
            let heroOrConeNumber = Int.random(in: 0...1)
            if heroOrConeNumber == 0 {
                let randomNumber = Int.random(in: 0...6)
                let image = legendaryConePictures[randomNumber]
                return image
            } else {
                let randomNumber = Int.random(in: 0...6)
                let image = legendaryHeroPictures[randomNumber]
                return image
            }
            
        case "Epic" :
            let heroOrConeNumber = Int.random(in: 0...1)
            if heroOrConeNumber == 0 {
                let randomNumber = Int.random(in: 0...35)
                let image = epicConePictures[randomNumber]
                return image
            } else {
                let randomNumber = Int.random(in: 0...13)
                let image = epicHeroPictures[randomNumber]
                return image
            }
            
        case "Common" :
            let randomNumber = Int.random(in: 0...20)
            let image = commonPictures[randomNumber]
            return image
            
        default :
            let image = UIImage(resource: .stars)
            return image
        }
    }
    
    func getImagesFromX10Rewards(rewards: [Reward]) -> [UIImage] {
        for reward in rewards {
            let image = didReceiveReward(reward)
            x10Images.append(image)
        }
        return x10Images
    }
    
    func setImagesForX10ImageViews(images: [UIImage], imageViews: [UIImageView]) {
        var count = 0
        for imageView in imageViews {
            imageView.image = images[count]
            count += 1
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

