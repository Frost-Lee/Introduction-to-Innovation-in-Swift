//
//  ViewController.swift
//  JourneyTotheWest
//
//  Created by 俞佳兴 on 2019/12/9.
//  Copyright © 2019 Albert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allCharactors = ["👨‍🦲", "🐒", "🐷", "👻"]
    var myChoices = ["👨‍🦲", "🐒", "🐷"]
    
    var pcChoices = [String]()
    var score = 0 {
        didSet {
            self.scoreLabel.text = "Score: \(score)"
        }
    }
    @IBOutlet var myChoiceButtons: [UIButton]!
    @IBOutlet var pcChoiceLabels: [UILabel]!
    
    @IBOutlet var gameView: UIView! {
        didSet {
            self.gameView.clipsToBounds = true
            self.gameView.layer.cornerRadius = 8.0
        }
    }
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBAction func shuffleButton(_ sender: UIButton) {
        shuffle()
        var result = ""
        if score > 0 {
            result = "You Win!"
        } else if score == 0 {
            result = "Try Again!"
        } else {
            result = "You Lose!"
        }
        let alert = UIAlertController(title: result, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeMyChoice(_ sender: UIButton) {
        if let firstIndex = myChoiceButtons.firstIndex(of: sender) {
            myChoices[firstIndex] = allCharactors.randomElement()!
            myChoiceButtons[firstIndex].setTitle(myChoices[firstIndex], for: .normal)
        }
    }
    
    func shuffle() {
        pcChoices.removeAll()
        score = 0
        for _ in 0..<myChoices.count {
            pcChoices.append(allCharactors.randomElement()!)
        }
        
        for index in 0..<pcChoices.count {
            let pcChoiceLabel = pcChoiceLabels[index]
            setupPCChoiceLabel(for: pcChoiceLabel, with: index)
        }
        
        for index in 0..<myChoices.count {
            let myChoiceButton = myChoiceButtons[index]
            setupMyChoiceButton(for: myChoiceButton, with: index)
        }
    }
    
    func setupMyChoiceButton(for button: UIButton, with index: Int) {
        button.setTitle(myChoices[index], for: .normal)
        
        let battleResult = battle(between: myChoices[index], and: pcChoices[index])
        if myChoices[index] == battleResult {
            score += 1
            button.backgroundColor = #colorLiteral(red: 0.7155902982, green: 0.8722988963, blue: 0.5982006788, alpha: 1)
        } else if battleResult == "" {
            button.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        } else {
            score -= 1
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 8.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
    }
    
    func setupPCChoiceLabel(for label: UILabel, with index: Int) {
        label.text = pcChoices[index]
        
        let battleResult = battle(between: myChoices[index], and: pcChoices[index])
        if pcChoices[index] == battleResult {
            label.backgroundColor = #colorLiteral(red: 0.7155902982, green: 0.8722988963, blue: 0.5982006788, alpha: 1)
        } else if battleResult == "" {
            label.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        } else {
            label.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        label.clipsToBounds = true
        label.layer.cornerRadius = 8.0
        label.font = UIFont.systemFont(ofSize: 40)
    }
    
    func battle(between a: String, and b: String) -> String {
        if a == "👨‍🦲" && b == "🐒" {
            return "👨‍🦲"
        } else if a == "👨‍🦲" && b == "👻" {
            return "👻"
        } else if a == "🐒" && b == "👨‍🦲" {
            return "👨‍🦲"
        } else if a == "🐒" && b == "🐷" {
            return "🐒"
        } else if a == "🐒" && b == "👻" {
            return "🐒"
        } else if a == "🐷" && b == "🐒" {
            return "🐒"
        } else if a == "🐷" && b == "👻" {
            return "🐷"
        } else if a == "👻" && b == "👨‍🦲" {
            return "👻"
        } else if a == "👻" && b == "🐒" {
            return "🐒"
        } else if a == "👻" && b == "🐷" {
            return "🐷"
        } else {
            return ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        shuffle()
    }


}

