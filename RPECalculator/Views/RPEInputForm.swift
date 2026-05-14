import SwiftUI

struct RPEInputForm: View {
    @Binding var input: RPEInput
    @Binding var minimumIncrement: Double
    var focusedField: FocusState<ContentView.Field?>.Binding

    var body: some View {
        VStack(spacing: 24) {
            InputField(
                title: "重量 kg",
                placeholder: "例：100",
                text: $input.weightText,
                keyboardType: .decimalPad
            )
            .focused(focusedField, equals: .weight)

            InputField(
                title: "回数",
                placeholder: "例：5",
                text: $input.repsText,
                keyboardType: .numberPad
            )
            .focused(focusedField, equals: .reps)

            VStack(alignment: .leading, spacing: 8) {
                Text("RPE：\(input.rpe, specifier: "%.1f")")
                    .font(.headline)

                Slider(value: $input.rpe, in: 6...10, step: 0.5)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("重量の刻み")
                    .font(.headline)

                Picker("重量の刻み", selection: $minimumIncrement) {
                    Text("1.25 kg").tag(1.25)
                    Text("2.5 kg").tag(2.5)
                    Text("5 kg").tag(5.0)
                }
                .pickerStyle(.segmented)
            }
        }
    }
}
