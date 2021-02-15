//
//  PrivacyPoliceViewController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 2/15/21.
//  Copyright © 2021 Islam Abotaleb. All rights reserved.
//

import UIKit
import WebKit
class PrivacyPoliceViewController: BaseViewController,WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initializeNavigationBarAppearanceWithBack(viewController: HomeViewController(), titleHeader: "كل يوم آية")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.

        let url = URL(string: "http://apps.shehabsalah.info/ayah/privacy_policy.html")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
