//
//  SplashViewController.swift
//  KolYoumAya
//
//  Created by Islam Abotaleb on 7/21/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    var coordinator: HomeCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        coordinator = HomeCoordinator(viewController: self)
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.coordinator?.start()

        }
    }
    
    deinit {
        self.coordinator?.didFinish()
    }
    
}
