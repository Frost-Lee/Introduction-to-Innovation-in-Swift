import Foundation
import UIKit

public var myChoices = ["👨‍🦲", "🐒", "🐷"]

public class GameViewController : UIViewController {
    let allCharactors = ["👨‍🦲", "🐒", "🐷", "👻"]
    
    var pcChoices = [String]()
    var myChoiceLabels = [UILabel]()
    var pcChoiceLabels = [UILabel]()
    let gameScoreLabel = UILabel()
    var score = 0 {
        didSet {
            self.gameScoreLabel.text = "Score: \(self.score)"
        }
    }
    
    override public func loadView() {
        for _ in 0..<myChoices.count {
            pcChoices.append(allCharactors.randomElement()!)
        }
        
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        self.view = view
        
        let gameView = UIView()
        gameView.clipsToBounds = false
        gameView.layer.cornerRadius = 8.0
        gameView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        self.view.addSubview(gameView)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "swift")
        self.view.addSubview(imageView)
        
        gameScoreLabel.text = "Score: 0"
        gameScoreLabel.textAlignment = .center
        gameScoreLabel.font = UIFont.systemFont(ofSize: 30)
        gameScoreLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        gameView.addSubview(gameScoreLabel)
        
        let shuffleButton = UIButton()
        shuffleButton.backgroundColor = .clear
        shuffleButton.setTitle("🎲", for: .normal)
        shuffleButton.titleLabel?.font = UIFont.systemFont(ofSize: 60)
        self.view.addSubview(shuffleButton)
        
        shuffleButton.addTarget(self, action: #selector(shuffle), for: .touchUpInside)
        
        for index in 0..<myChoices.count {
            let myChoiceLabel = UILabel()
            setupMyChoiceLabel(for: myChoiceLabel, with: index)
            myChoiceLabels.append(myChoiceLabel)
            gameView.addSubview(myChoiceLabel)
            myChoiceLabel.translatesAutoresizingMaskIntoConstraints = false
        }
        
        for index in 0..<pcChoices.count {
            let pcChoiceLabel = UILabel()
            setupPCChoiceLabel(for: pcChoiceLabel, with: index)
            pcChoiceLabels.append(pcChoiceLabel)
            gameView.addSubview(pcChoiceLabel)
            pcChoiceLabel.translatesAutoresizingMaskIntoConstraints = false
        }
        
        gameView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        gameScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            gameView.widthAnchor.constraint(equalToConstant: 300),
            gameView.heightAnchor.constraint(equalToConstant: 460),
            
            shuffleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shuffleButton.topAnchor.constraint(equalTo: gameView.bottomAnchor, constant: 5),
            shuffleButton.widthAnchor.constraint(equalToConstant: 100),
            shuffleButton.heightAnchor.constraint(equalToConstant: 100),
            
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            gameScoreLabel.topAnchor.constraint(equalTo: gameView.topAnchor, constant: 10),
            gameScoreLabel.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            gameScoreLabel.heightAnchor.constraint(equalToConstant: 60),
            gameScoreLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        for index in 0..<myChoices.count {
            let myChoiceLabel = myChoiceLabels[index]
            NSLayoutConstraint.activate([
                myChoiceLabel.widthAnchor.constraint(equalToConstant: 80),
                myChoiceLabel.heightAnchor.constraint(equalToConstant: 80),
                myChoiceLabel.topAnchor.constraint(equalTo: gameView.topAnchor, constant: CGFloat(120*(index)+80)),
                myChoiceLabel.leftAnchor.constraint(equalTo: gameView.leftAnchor, constant: 40),
            ])
        }
        
        for index in 0..<pcChoices.count {
            let pcChoiceLabel = pcChoiceLabels[index]
            NSLayoutConstraint.activate([
                pcChoiceLabel.widthAnchor.constraint(equalToConstant: 80),
                pcChoiceLabel.heightAnchor.constraint(equalToConstant: 80),
                pcChoiceLabel.topAnchor.constraint(equalTo: gameView.topAnchor, constant: CGFloat(120*(index)+80)),
                pcChoiceLabel.rightAnchor.constraint(equalTo: gameView.rightAnchor, constant: -40),
            ])
        }
    }
    
    func setupMyChoiceLabel(for label: UILabel, with index: Int) {
        label.text = myChoices[index]
        label.textColor = .black
        label.textAlignment = .center
        
        let battleResult = battle(between: myChoices[index], and: pcChoices[index])
        if myChoices[index] == battleResult {
            score += 1
            label.backgroundColor = #colorLiteral(red: 0.7155902982, green: 0.8722988963, blue: 0.5982006788, alpha: 1)
        } else if battleResult == "" {
            label.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        } else {
            score -= 1
            label.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        label.clipsToBounds = true
        label.layer.cornerRadius = 8.0
        label.font = UIFont.systemFont(ofSize: 40)
    }
    
    func setupPCChoiceLabel(for label: UILabel, with index: Int) {
        label.text = pcChoices[index]
        label.textColor = .black
        label.textAlignment = .center
        
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
    
    @objc func shuffle() {
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
            let myChoiceLabel = myChoiceLabels[index]
            setupMyChoiceLabel(for: myChoiceLabel, with: index)
        }
    }
}
