var scores = [32, 38, 24, 48, 21, 45, 37, 20, -1]
var passNumber = 0
var failNumber = 0
var errorNumber = 0
for score in scores {
    if score >= 32 {
        passNumber += 1
    } else if score >= 0 {
        failNumber += 1
    } else {
        errorNumber += 1
    }
}

print("合格: \(passNumber)", "不合格: \(failNumber)", "错误: \(errorNumber)")


//var zhaoBinScore: Int? = nil
//print(zhaoBinScore)

var zhaoBinScore: Int? = nil
if let score = zhaoBinScore {
    print(score)
}

var defaultScore = 0
print(zhaoBinScore ?? defaultScore)


let allScores = [
    "computerScience": [48, 34, 23, 50, 49],
    "software": [48, 36, 50, 28, 48],
    "industrialDesign": [30, 45, 32, 48, 18],
]

var maxScore = 32
var minScore = 32

for (_, scores) in allScores {
    for score in scores {
        if maxScore <= score {
            maxScore = score
        }
        if minScore >= score {
            minScore = score
        }
    }
}

print("最高分: \(maxScore)", "最低分: \(minScore)")


var avgOfSoftWare = 0
var totalOfSoftWare = 0
var softWareScore = [48, 36, 50, 28, 48]
var index = 0

while index < softWareScore.count {
    totalOfSoftWare += softWareScore[index]
    index += 1
}

avgOfSoftWare = totalOfSoftWare / softWareScore.count

print(avgOfSoftWare)


var comment = "无"

switch comment {
case "优秀":
    print("取得了优秀的成绩！你真棒！")
case "良好":
    print("不错！继续加油！")
case "合格":
    print("还有进步的空间！")
case "不合格":
    print("记得补考！")
default:
    print("评语出错！")
}

