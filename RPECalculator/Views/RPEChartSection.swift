import SwiftUI

struct RPEChartSection: View {
    let oneRM: Double
    @Binding var selectedReps: Int
    let minimumIncrement: Double
    let onDismissKeyboard: () -> Void
    private var rows: [RPEChartRow] {
        RPEFormula.chartRows(for: selectedReps)
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("RPE換算表")
                .font(.largeTitle)
                .bold()
            repsSelector
            chartTable
        }
    }

    private var repsSelector: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("回数")
                .font(.headline)
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible(), spacing: 12),
                    count: 5
                ),
                spacing: 12
            ) {
                ForEach(1...10, id: \.self) { reps in
                    Button {
                        onDismissKeyboard()
                        selectedReps = reps
                    } label: {
                        Text("\(reps)")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(
                                selectedReps == reps ? Color.blue : Color.clear
                            )
                            .foregroundStyle(
                                selectedReps == reps ? .white : .blue
                            )
                            .cornerRadius(8)
                    }
                }
            }
        }
    }

    private var chartTable: some View {
        VStack(spacing: 0) {
            Divider()

            HStack {
                Text("RPE")
                    .font(.headline)
                    .frame(maxWidth: .infinity)

                Text("% of 1RM")
                    .font(.headline)
                    .frame(maxWidth: .infinity)

                Text("使用重量")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 16)

            Divider()

            ForEach(rows) { row in
                HStack {
                    Text(RPEFormula.formatRPE(row.rpe))
                        .frame(maxWidth: .infinity)

                    Text("\(row.percent * 100, specifier: "%.1f")%")
                        .frame(maxWidth: .infinity)

                    Text("\(load(for: row), specifier: "%.1f")")
                        .frame(maxWidth: .infinity)
                }
                .font(.title3)
                .padding(.vertical, 6)
            }
        }
    }

    private func load(for row: RPEChartRow) -> Double {
        RPEFormula.roundedLoad(
            oneRM * row.percent,
            increment: minimumIncrement
        )
    }
}
