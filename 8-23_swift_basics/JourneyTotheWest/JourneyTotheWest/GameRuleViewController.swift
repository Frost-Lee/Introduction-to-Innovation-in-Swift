//
//  GameRuleViewController.swift
//  JourneyTotheWest
//
//  Created by 俞佳兴 on 2019/12/12.
//  Copyright © 2019 Albert. All rights reserved.
//

import UIKit

class GameRuleViewController: UIViewController {

    @IBOutlet var startButton: UIButton! {
        didSet {
            self.startButton.clipsToBounds = true
            self.startButton.layer.cornerRadius = 8.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
