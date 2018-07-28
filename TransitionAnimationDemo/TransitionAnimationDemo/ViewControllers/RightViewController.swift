//
//  RightViewController.swift
//  TransitionAnimationDemo
//
//  Created by grwong on 2018/7/24.
//  Copyright © 2018年 grwong. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {
    
    var rightInteractionController: RightDismissInterationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 235/255.0, green: 119/255.0, blue: 106/255.0, alpha: 1.0)
        addDismissBtn()
        rightInteractionController = RightDismissInterationController(viewController: self)
    }

    private func addDismissBtn() {
        let dismissBtn = UIButton(type: .custom)
        dismissBtn.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        dismissBtn.backgroundColor = UIColor(red: 74/255.0, green: 180/255.0, blue: 229/255.0, alpha: 1.0)
        dismissBtn.setTitle("dismiss right VC", for: .normal)
        dismissBtn.setTitleColor(.white, for: .normal)
        dismissBtn.addTarget(self, action: #selector(dismissBtnAction), for: .touchUpInside)
        view.addSubview(dismissBtn)
    }
    
    @objc func dismissBtnAction() {
        self.dismiss(animated: true, completion: nil)
    }

}
