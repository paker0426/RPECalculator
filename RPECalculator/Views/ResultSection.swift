import SwiftUI

struct ResultSection: View {
    let estimatedOneRM: Double
    let minimumIncrement: Double

    private var roundedOneRM: Double {
        RPEFormula.roundedLoad(
            estimatedOneRM,
            increment: minimumIncrement
        )
    }

    var body: some View {
        HStack {
            Text("推定1RM")
                .font(.title)
                .bold()

            Spacer()

            Text("\(roundedOneRM, specifier: "%.1f") kg")
                .font(.title2)
        }
        .padding(.top, 16)
    }
}
