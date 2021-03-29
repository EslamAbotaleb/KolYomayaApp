//
//  DetailMediaProgramSelectedController.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/27/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit

class DetailMediaProgramSelectedController: BaseViewController  {
    var delegateElsharawyProgramId: DelegateElsharawayMediaSelect?

    
    @IBOutlet weak var videoCoverImage: UIImageView!
    @IBOutlet weak var playBuuton: UIButton!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var titleEpsiodeLbl: UILabel!
    var viewModel: MediaList?
    //(self.viewModel?.program!.programName)!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.initializeNavigationBarAppearanceWithBack(viewController: ElsharawyMediaProgramIdViewController(), titleHeader: delegateElsharawyProgramId?.programName ?? "كل يوم آية"
        )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videoCoverImage.imageFromURL(urlString: (viewModel?.videoCover)!)
        self.sourceLbl.text = viewModel?.mediaListDescription
        self.titleEpsiodeLbl.text = viewModel?.title
        self.playBuuton.addTarget(self, action: #selector(openYoutube(sender:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
       
    }
    func playInYoutube(youtubeId: String) {
        if let youtubeURL = URL(string: "youtube://\(youtubeId)"),
            UIApplication.shared.canOpenURL(youtubeURL) {
            // redirect to app
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        } else if let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(youtubeId)") {
            // redirect through safari
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        }
    }
    @objc func openYoutube(sender: UIButton) {
        playInYoutube(youtubeId: viewModel!.video!)
//        let youtubeId = viewModel!.video
//        print("viewModel!.videoviewModel!.video\(viewModel!.video!)")
//           var url = URL(string:"youtube://\(youtubeId)")!
//           if !UIApplication.shared.canOpenURL(url)  {
//               url = URL(string:"http://www.youtube.com/watch?v=\(youtubeId)")!
//           }
//           UIApplication.shared.open(url, options: [:], completionHandler: nil)
//
       
//        UIApplication.shared.open(URL(string: "https://www.youtube.com/watch?v=\(viewModel?.video)")! as URL, options: [:], completionHandler: nil)
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
