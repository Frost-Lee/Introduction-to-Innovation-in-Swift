enum Country {
    case Wei
    case Shu
    case Wu
    case Qun
    
    func cof() -> Double {
        switch self {
        case .Wei: return 2
        case .Wu: return 1.5
        case .Shu: return 1
        case .Qun: return 0.5
        }
    }
}

enum Type {
    case Fashi
    case Zhanshi
    case Sheshou
    case Tanke
    case Cike
    
    func damage() -> Double {
        switch self {
        case .Fashi: return 28
        case .Zhanshi: return 20
        case .Sheshou: return 32
        case .Tanke: return 16
        case .Cike: return 40
        }
    }
    
    func blood() -> Double {
        switch self {
        case .Fashi: return 800
        case .Zhanshi: return 1000
        case .Sheshou: return 700
        case .Tanke: return 1400
        case .Cike: return 600
        }
    }
}

struct Card {
    var country: Country
    var type: Type
    var blood: Double {
        willSet {
            print("Original blood: \(blood).")
        }
        didSet {
            print("Current blood: \(blood).\n")
        }
    }
    
    init(country: Country, type: Type) {
        self.country = country
        self.type = type
        self.blood = type.blood()
    }
}


var card1 = Card(country: .Qun, type: .Cike)
var card2 = Card(country: .Wei, type: .Sheshou)

func computeDamage(card: Card) -> Double {
    return card.country.cof() * card.type.damage()
}

//
var round = 0
while card1.blood > 0 && card2.blood > 0 {
    round += 1
    print("Round \(round)")
    
    print("Card1 beats Card2.")
    card2.blood -= computeDamage(card: card1)
    
    print("Card2 beats Card1.")
    card1.blood -= computeDamage(card: card2)
}

if card1.blood <= 0 {
    print("Card1 Dead.")
} else {
    print("Card2 Dead.")
}

print("Total Round: \(round).")
