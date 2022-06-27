//
//  CooseGameViewController.swift
//  Game
//
//  Created by Spring on 2018/4/15.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import UIKit

class ChoseGameViewController: BaseViewController {
    
    private(set) lazy var game2 = createGameBtn(name: "24 Game")
    
    private(set) lazy var game3 = createGameBtn(name: "Ferris")

    private(set) lazy var bgView = UIView.init(frame: CGRect.init(x: (ScreenWidth - 250) * 0.5, y: (ScreenHeight - 160 - 100) * 0.5, width: 250, height: 160))

    private let topImage = UIImageView(image: UIImage(named: "EllipseBlue"))
    private let bottomImage = UIImageView(image: UIImage(named: "EllipseGreen"))
    private let backBlur = UIVisualEffectView(effect:  UIBlurEffect(style: .dark))

    private let titleLabel = UILabel(text: "Game Box", font: UIFont.systemFont(ofSize: 26, weight: .heavy), color: UIColor.white, alignment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.themeColor
        view.addSubview(topImage)
        view.addSubview(bottomImage)
        view.addSubview(backBlur)


        topImage.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(1.3)
            make.height.equalTo(topImage.snp.width)
            make.centerX.equalTo(view.snp.trailing)
            make.centerY.equalTo(view.snp.top)
        }

        bottomImage.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(1.3)
            make.height.equalTo(topImage.snp.width)
            make.centerX.equalTo(view.snp.leading)
            make.centerY.equalTo(view.snp.bottom)
        }

        backBlur.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backBlur.contentView.addSubview(titleLabel)
        backBlur.contentView.addSubview(bgView)
        bgView.layer.cornerRadius = 16
        bgView.clipsToBounds = true
        bgView.backgroundColor = pinColor

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.5)
        }

        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.3)
        }

        bgView.addSubview(game2)
        bgView.addSubview(game3)
        game2.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(backBlur.contentView.snp.width).multipliedBy(0.5)
            make.top.leading.equalTo(12)
            make.trailing.equalTo(-12)
        }

        game3.snp.makeConstraints { make in
            make.top.equalTo(game2.snp.bottom).offset(12)
            make.height.equalTo(60)
            make.width.equalTo(backBlur.contentView.snp.width).multipliedBy(0.5)
            make.bottom.trailing.equalTo(-12)
            make.leading.equalTo(12)
        }

        game2.tag = 2
        game3.tag = 3
    }
    
    private func createGameBtn(name:String) -> UIButton {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.clipsToBounds = true
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.themeColor?.cgColor
        btn.backgroundColor = blueColor
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle(name, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn;
    }
    
    @objc func btnClick(sender:UIButton) -> Void {
        if(sender.tag == 1){
            
        }else if(sender.tag == 2){
            let game2Vc = Game24ViewController()
            self.navigationController?.pushViewController(game2Vc, animated: true)
        }else if(sender.tag == 3){
            let ferrisVc = FerrisViewController()
            self.navigationController?.pushViewController(ferrisVc, animated: true)
        }else if(sender.tag == 4){
            
        }
    }
    //返回上一级
    @objc func backClick() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
}
