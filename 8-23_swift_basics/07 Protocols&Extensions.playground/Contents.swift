//1
protocol Tax {
    var national: Double { get }
    var state: Double { get set }
    var individual: Double { get set }
    func totalTax() -> Double
    mutating func changeTax(newTax: Double)
}


class California: Tax {
    
    let national: Double = 0.25
    
    var state: Double = 0.05
    
    var individual: Double = 0.1
    
    func changeTax(newTax: Double) {
        state = newTax
    }
    
}

class Ohio: Tax {
    
    let national: Double = 0.25
    
    var state: Double = 0.03
    
    var individual: Double = 0.1
    
    func changeTax(newTax: Double) {
        state = newTax
    }
}

struct Texas: Tax, Donate {
    let donateRate: Double = 0.01
    
    let national: Double
    
    var state: Double
    
    var individual: Double
    
    mutating func changeTax(newTax: Double) {
        state = newTax
    }
}

protocol Donate {
    var donateRate: Double { get }
}

extension Tax {
    func totalTax() -> Double {
        return national + state + individual
    }
}

extension Int {
    var abs: Int {
        get {
            if self > 0 {
                return self
            } else {
                return -self
            }
        }
    }
    
    func check() -> String {
        if self > 50000 {
            return ("Tax needed!")
        } else {
            return ("No need for tax!")
        }
    }
}

print((-2).abs)

print(300.check())


extension Array {
    func dao() -> Array {
        var temp = Array()
        var index = self.count - 1
        while index >= 0 {
            temp.append(self[index])
            
            index -= 1
        }
        return temp
    }
}

print([1, 3, 2, 4].dao())
