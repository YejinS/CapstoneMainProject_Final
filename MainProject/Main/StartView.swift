//
//  StartView.swift
//  MainProject
//
//  Created by 김나현 on 2022/04/18.
//

import UIKit

class StartView: UIViewController {

    @IBOutlet weak var startLogoImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let leavitLogoGif = UIImage.gifImageWithName("leavit_nobg_gif")
        startLogoImg.image = leavitLogoGif
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
