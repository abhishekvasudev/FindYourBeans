import SwiftUI

struct ColorView: View {
    
    let colorStyle: ColorStyle
    
    var body: some View {
        switch colorStyle {
        case .color(let color):
            color
        case .linearGraident((let colors, let startPoint, let endPoint)):
            LinearGradient(colors: colors,
                           startPoint: startPoint,
                           endPoint: endPoint)
        }
    }
    
}

protocol ColorStyleProtocol {
    var style: AnyShapeStyle { get }
}

enum ColorStyle: ColorStyleProtocol {
    case color(Color)
    case linearGraident((colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint))
    
    var style: AnyShapeStyle {
        switch self {
        case .color(let color):
            return AnyShapeStyle(color)
        case .linearGraident((let colors, let startPoint, let endPoint)):
            return AnyShapeStyle(.linearGradient(colors: colors, startPoint: startPoint, endPoint: endPoint))
        }
    }
}
