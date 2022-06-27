//
//  BaseViewController.swift
//  Game


import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.themeColor
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
