import Foundation

struct RPEInput {
    var weightText = ""
    var repsText = ""
    var rpe = 8.0

    var weight: Double? {
        guard let value = Double(weightText), value > 0 else {
            return nil
        }
        return value
    }

    var reps: Double? {
        guard let value = Double(repsText), value > 0, value <= 20 else {
            return nil
        }
        return value
    }

    var isEmpty: Bool {
        weightText.isEmpty && repsText.isEmpty
    }

    var isValid: Bool {
        weight != nil && reps != nil
    }
}
