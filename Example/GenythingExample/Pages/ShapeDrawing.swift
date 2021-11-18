import SwiftUI
import Genything

struct PolygonParams {
    let sides: Int
    let scale: Double
    let color: Color
    let offset: CGFloat
    let xOffset: CGFloat
}

struct ShapeDrawing: View {
    private let random: Bool
    private let polygonParamsGen = Gen<PolygonParams>.compose {
        var colors: Gen<Color>
        if #available(iOS 15.0, *) {
            colors = Gen.of([Color.red, Color.yellow, Color.pink, Color.purple, Color.black, Color.green, Color.indigo, Color.cyan])
        } else {
            colors = Gen.of([Color.red, Color.yellow, Color.pink, Color.purple, Color.black, Color.green])
        }
        return PolygonParams(
            sides: $0.generate(Gen.from(3...8)),
            scale: $0.generate(Gen.from(0.3...0.9)),
            color: $0.generate(colors),
            offset: CGFloat($0.generate(Gen.from(-250.0...250.0))),
            xOffset:CGFloat($0.generate(Gen.from(-150.0...150.0)))
        )
    }

    @State var context: Context = .default
    @State var polygons: [PolygonShape] = []

    init(random: Bool = false) {
        self.random = random
    }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach (polygons) { polygon in
                polygon
                    .fill(polygon.color)
                    .opacity(0.5)
                    .offset(
                        x: polygon.xOffset,
                        y: polygon.offset
                    )
            }
        }
        .onAppear {
            context = random ? .random : .default
            polygons = polygonParamsGen
                .expand(toSize: 8)
                .map { polygon in
                    polygon.map { p in
                        PolygonShape(
                            id: UUID(),
                            sides: Double(p.sides),
                            scale: p.scale,
                            color: p.color,
                            offset: p.offset,
                            xOffset: p.xOffset
                        )
                    }
                }
                .generate(context: context)
        }
    }
}

struct ShapeDrawing_Previews: PreviewProvider {
    static var previews: some View {
        ShapeDrawing()
    }
}
