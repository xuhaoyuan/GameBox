//
//  AppDelegate.swift
//  Game
//
//  Created by Spring on 2018/4/15.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let vc = ChoseGameViewController()
        let nav = BaseNavigationController(rootViewController: vc)
        nav.delegate = self
        nav.navigationBar.isHidden = true

        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }
}

class BaseNavigationController: UINavigationController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension AppDelegate: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatedTransition(operation: operation)
    }
}


class AnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {

    let operation: UINavigationControllerOperation
    init(operation: UINavigationControllerOperation) {
        self.operation = operation
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch operation {
        case .push:
            push(using: transitionContext)
        case .pop:
            pop(using: transitionContext)
        case .none:
            break
        }
    }

    private func push(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ChoseGameViewController else { return }
        let greenView: UIButton
        switch transitionContext.viewController(forKey: .to) {
        case is FerrisViewController:
            greenView = createGameBtn(name: fromVC.game3.title(for: .normal) ?? "")
            greenView.frame = fromVC.view.convert(fromVC.game3.bounds, from: fromVC.game3)
        case is Game24ViewController:
            greenView = createGameBtn(name: fromVC.game2.title(for: .normal) ?? "")
            greenView.frame = fromVC.view.convert(fromVC.game2.bounds, from: fromVC.game2)
        default:
            return
        }


        let contentView = transitionContext.containerView

        guard let toView = transitionContext.view(forKey: .to) else { return }
        let backView = UIView(color: fromVC.bgView.backgroundColor ?? .clear)
        backView.frame = fromVC.bgView.frame
        backView.cornerRadius = 16
        contentView.addSubview(toView)
        contentView.addSubview(backView)
        contentView.addSubview(greenView)
        toView.alpha = 0

        greenView.layer.cornerRadius = 12

        let size = UIScreen.main.bounds.size
        let duration: TimeInterval = 0.6
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [.calculationModeLinear]) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration*0.5) {
                greenView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                greenView.layer.borderWidth = 0
                greenView.titleLabel?.alpha = 0
                backView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: duration*0.5) {
                let halfHeight: CGFloat = size.height/2
                greenView.layer.cornerRadius = 0
                backView.layer.cornerRadius = 0
                greenView.transform = CGAffineTransform.identity
                backView.transform = CGAffineTransform.identity
                backView.frame = CGRect(x: 0, y: 0, width: size.width, height: halfHeight)
                greenView.frame = CGRect(x: 0, y: halfHeight, width: size.width, height: halfHeight)
            }
        } completion: { _ in
            toView.alpha = 1
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut]) {
                backView.frame = CGRect(x: 0, y: 0, width: size.width, height: 0)
                greenView.frame = CGRect(x: 0, y: size.height, width: size.width, height: 0)
            } completion: { _ in
                transitionContext.completeTransition(true)
                greenView.removeFromSuperview()
                backView.removeFromSuperview()
            }
        }
    }

    private func pop(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) as? ChoseGameViewController else { return }
        let greenView: UIButton
        let endGreenViewRect: CGRect
        switch transitionContext.viewController(forKey: .from) {
        case is FerrisViewController:
            greenView = createGameBtn(name: "")
            endGreenViewRect = toVC.view.convert(toVC.game3.bounds, from: toVC.game3)
        case is Game24ViewController:
            greenView = createGameBtn(name: "")
            endGreenViewRect = toVC.view.convert(toVC.game2.bounds, from: toVC.game2)
        default:
            return
        }
        greenView.titleLabel?.alpha = 0
        greenView.layer.borderWidth = 0
        greenView.cornerRadius = 0

        let contentView = transitionContext.containerView

        guard let toView = transitionContext.view(forKey: .to) else { return }
        let backView = UIView(color: toVC.bgView.backgroundColor ?? .clear)
        //        backView.frame = toVC.bgView.frame
        contentView.addSubview(toView)
        contentView.addSubview(backView)
        contentView.addSubview(greenView)
        toView.alpha = 0

        let size = UIScreen.main.bounds.size
        backView.frame = CGRect(x: 0, y: 0, width: size.width, height: 0)
        greenView.frame = CGRect(x: 0, y: size.height, width: size.width, height: 0)
        UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState, .curveEaseOut]) {
            let halfHeight: CGFloat = size.height/2
            backView.frame = CGRect(x: 0, y: 0, width: size.width, height: halfHeight)
            greenView.frame = CGRect(x: 0, y: halfHeight, width: size.width, height: halfHeight)
        } completion: { _ in
            toView.alpha = 1
            let duration: TimeInterval = 0.6
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: [.calculationModeLinear]) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration*0.5) {
                    greenView.frame = endGreenViewRect
                    greenView.cornerRadius = 12
                    greenView.layer.borderWidth = 3
                    backView.frame = toVC.bgView.frame
                    backView.cornerRadius = 16
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: duration*0.5) {
                    greenView.alpha = 0
                    backView.alpha = 0
                }
            } completion: { _ in
                transitionContext.completeTransition(true)
                greenView.removeFromSuperview()
                backView.removeFromSuperview()
            }
        }
    }

    func createGameBtn(name:String) -> UIButton {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.clipsToBounds = true
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.themeColor?.cgColor
        btn.backgroundColor = blueColor
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle(name, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return btn;
    }
}

