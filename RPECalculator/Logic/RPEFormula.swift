import Foundation

struct RPEFormula {
    // 推定1RMを計算
    static func estimateOneRM(weight: Double?, reps: Double?, rpe: Double)
        -> Double?
    {
        guard let weight,
            let reps,
            weight > 0,
            reps > 0
        else {
            return nil
        }

        let rir = 10.0 - rpe
        let adjustedReps = reps + rir

        return weight * (1 + adjustedReps / 30)
    }
    // RPE表の行データを作成
    static func chartRows(for reps: Int) -> [RPEChartRow] {
        let rpeValues = stride(from: 10.0, through: 6.0, by: -0.5)

        return rpeValues.map { rpe in
            let rir = 10.0 - rpe
            let adjustedReps = Double(reps) + rir
            let percent = 1.0 / (1.0 + adjustedReps / 30.0)

            return RPEChartRow(
                rpe: rpe,
                percent: percent
            )
        }
    }
    //重量を指定単位で丸める
    static func roundedLoad(_ load: Double, increment: Double) -> Double {
        (load / increment).rounded() * increment
    }
    //RPEの表示形式を整える
    static func formatRPE(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", value)
        } else {
            return String(format: "%.1f", value)
        }
    }
}
