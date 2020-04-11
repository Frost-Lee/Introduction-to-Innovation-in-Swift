enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
    case other
    
    var locolizedDescription: String {
        switch self {
        case .outOfPaper:
            return "The Printer is out of paper."
        case .noToner:
            return "The printer has no toner."
        case .onFire:
            return "The printer is working, try again later."
        case .other:
            return "Unknown reason."
        }
    }
}

let results = ["normal", "normal", "normal", "normal", "normal", "normal", "normal", "normal", "Out of Paper", "No Toner", "On the fire"]

func send(job: Int, withResult result: String) throws -> String {
    switch result {
    case "normal":
        return "Job Sent!"
    case "Out of Paper":
        throw PrinterError.outOfPaper
    case "No Toner":
        throw PrinterError.noToner
    case "On the fire":
        throw PrinterError.onFire
    default:
        throw PrinterError.other
    }
}


do {
    let printerResponse = try send(job: 1024, withResult: results.randomElement()!)
    print(printerResponse)
} catch let printerError as PrinterError {
    print(printerError.locolizedDescription)
    // Error Handling ...
    
}
