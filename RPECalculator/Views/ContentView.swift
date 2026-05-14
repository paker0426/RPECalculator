import SwiftUI

struct ContentView: View {
    enum Field {
        case weight
        case reps
    }

    @State private var input = RPEInput()
    @State private var selectedChartReps = 1
    @State private var minimumIncrement = 2.5
    @FocusState private var focusedField: Field?

    private var estimatedOneRM: Double? {
        guard let weight = input.weight,
              let reps = input.reps else {
            return nil
        }

        return RPEFormula.estimateOneRM(
            weight: weight,
            reps: reps,
            rpe: input.rpe
        )
    }

    private var roundedOneRM: Double? {
        guard let estimatedOneRM else {
            return nil
        }

        return RPEFormula.roundedLoad(
            estimatedOneRM,
            increment: minimumIncrement
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                header

                RPEInputForm(
                    input: $input,
                    minimumIncrement: $minimumIncrement,
                    focusedField: $focusedField
                )

                if let estimatedOneRM,
                   let roundedOneRM {
                    ResultSection(
                        estimatedOneRM: estimatedOneRM,
                        minimumIncrement: minimumIncrement
                    )

                    RPEChartSection(
                        oneRM: roundedOneRM,
                        selectedReps: $selectedChartReps,
                        minimumIncrement: minimumIncrement,
                        onDismissKeyboard: {
                            focusedField = nil
                        }
                    )
                } else {
                    inputGuideMessage
                }
            }
            .padding()
        }
        .onTapGesture {
            focusedField = nil
        }
    }

    private var header: some View {
        VStack(spacing: 8) {
            Text("RPE Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("重量・回数・RPEから推定1RMを計算します")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var inputGuideMessage: some View {
        Text("重量と回数を入力すると、推定1RMが表示されます。")
            .font(.callout)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
