//1
//func <#name#>(<#parameters#>) -> <#return type#> {
//    <#function body#>
//}

//2
//func moveBody(with distance: Int) -> String {
//    for _ in 1...distance {
//        moveForward()
//    }
//
//    for _ in 1...distance {
//        moveToLeft()
//    }
//
//    for _ in 1...distance {
//        moveBackward()
//    }
//
//    for _ in 1...distance {
//        moveToRight()
//    }
//
//    return "finished"
//}

//func plus(_ a: Int, and b: Int) -> Int {
//    return a + b
//}
//
//print(plus(2, and: 3))


func money(start: Double, rate: Double) -> Double {
    func interest(withMoney: Double) -> Double {
        return start * rate
    }
    
    return start + interest(withMoney: start)
}

print(money(start: 12000, rate: 0.0315))

//6
{ (<#parameters#>) -> <#return type#> in
    <#statements#>
}

func <#name#>(<#parameters#>) -> <#return type#> {
    <#function body#>
}
