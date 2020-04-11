// 开始游戏
print("Start Game!")

// 请从"👨‍🦲"、"🐒"、"👻"选择一个
var allCharactors = ["👨‍🦲", "🐒", "👻"]

// 你的出招顺序
var firstRound = "👨‍🦲"
print("FirstRound You Choose \(firstRound)!")
var secondRound = "👨‍🦲"
print("SecondRound You Choose \(secondRound)!")
var thirdRound = "👨‍🦲"
print("ThirdRound You Choose \(thirdRound)!")

// 游戏规则
func battle(between a: String, and b: String) -> String {
    if a == "👨‍🦲" && b == "🐒" {
        return "👨‍🦲"
    } else if a == "👨‍🦲" && b == "👻" {
        return "👻"
    } else if a == "🐒" && b == "👻" {
        return "🐒"
    } else {
        return ""
    }
}

// 电脑随机出招
var randomFirstRound = allCharactors.randomElement()!
var randomSecondRound = allCharactors.randomElement()!
var randomThirdRound = allCharactors.randomElement()!

// 每轮PK结果
var totalScore = 0
let firstRoundResult = battle(between: firstRound, and: randomFirstRound)
if firstRound == firstRoundResult {
    totalScore += 1
    print("FirstRound You Win!")
} else if firstRoundResult == "" {
    print("FirstRound The Same!")
} else {
    totalScore -= 1
    print("FirstRound You Lose!")
}

let secondRoundResult = battle(between: secondRound, and: randomSecondRound)
if secondRound == secondRoundResult {
    totalScore += 1
    print("SecondRound You Win!")
} else if secondRoundResult == "" {
    print("SecondRound The Same!")
} else {
    totalScore -= 1
    print("SecondRound You Lose!")
}

let thirdRoundResult = battle(between: thirdRound, and: randomThirdRound)
if thirdRound == thirdRoundResult {
    totalScore += 1
    print("ThirdRound You Win!")
} else if thirdRoundResult == "" {
    print("ThirdRound The Same!")
} else {
    totalScore -= 1
    print("ThirdRound You Lose!")
}

// 最终游戏结果
if totalScore >= 1 {
    print("You win the Game!")
} else if totalScore == 0 {
    print("Try again!")
} else {
    print("You lose the Game!")
}


var yourChoices = [firstRound, secondRound, thirdRound]
var randomChoices = [randomFirstRound, randomSecondRound, randomThirdRound]
var totalScores = 0
for index in 0...yourChoices.count - 1 {
    let result = battle(between: yourChoices[index], and: randomChoices[index])
    if yourChoices[index] == result {
        totalScores += 1
        print("Round \(index + 1): You Win!")
    } else if result == "" {
        print("Round \(index + 1): The Same!")
    } else {
        totalScores -= 1
        print("Round \(index + 1): You Lose!")
    }
}

if totalScores >= 1 {
    print("You win the Game!")
} else if totalScores == 0 {
    print("Try again!")
} else {
    print("You lose the Game!")
}
