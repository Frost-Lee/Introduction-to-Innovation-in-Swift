import UIKit

//class Pet {
//    var sex: Int
//    var color: UIColor
//    var rarity: String
//
//    func earnMoney() -> Int {
//        return 10
//    }
//
//    init(sex: Int, color: UIColor, rarity: String) {
//        self.sex = sex
//        self.color = color
//        self.rarity = rarity
//    }
//
//}
//
//class Cat: Pet {
//    var cloths: [String]
//
//    init(cloths: [String], sex: Int, color: UIColor, rarity: String) {
//        self.cloths = cloths
//        super.init(sex: sex, color: color, rarity: rarity)
//    }
//}
//
//var kitty = Cat(cloths: ["hat", "T-shirt"], sex: 1, color: .blue, rarity: "Legend")
//



class Pet {
    var sex: Int
    var color: UIColor
    var rarity: String

    func earnMoney() -> Int {
        return 10
    }

    init(sex: Int, color: UIColor, rarity: String) {
        self.sex = sex
        self.color = color
        self.rarity = rarity
    }
}

class Cat: Pet {
    var cloths: [String]

    override func earnMoney() -> Int {
        switch rarity {
        case "Legend": return 20
        case "Rare": return 10
        case "Normal": return 1
        default: return 0
        }
    }

    init(cloths: [String], sex: Int, color: UIColor, rarity: String) {
        self.cloths = cloths
        super.init(sex: sex, color: color, rarity: rarity)
    }
}
var Kitty = Cat(cloths: ["hat", "T-shirt"], sex: 1, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), rarity: "Legend")
var Tom = Cat(cloths: ["hat", "Jeans"], sex: 0, color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), rarity: "Normal")

//
//var money = 0
//
//money += kitty.earnMoney()
//



var money = 0 {
    willSet {
        print("Original Money: \(money).")
    }
    didSet {
        print("Now you have \(money) yuan.")
    }
}

money += Kitty.earnMoney()
money += Tom.earnMoney()
