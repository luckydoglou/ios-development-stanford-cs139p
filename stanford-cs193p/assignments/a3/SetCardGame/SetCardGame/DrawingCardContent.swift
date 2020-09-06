//
//  DrawingCardContent.swift
//  SetCardGame
//
//  Created by Lor Worwag on 9/4/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

struct DrawingCardContent: View {
    var content: CardContent
    
    var body: some View {
        VStack {
//            Text("\(content.numberOfShapes.rawValue)")
//            Text(content.colour.rawValue)
//            Text(content.shape.rawValue)
//            Text(content.shading.rawValue)
            
            ForEach(0..<content.numberOfShapes.rawValue, id: \.self) { _ in
                self.shape
                    .shading(type: self.content.shading)
                    .overlay(self.shape.stroke(lineWidth: 3))
                    .foregroundColor(self.color)
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }

    // MARK: - Convert CardContent.Colour to SwiftUI.Color
    
    var color: Color {
        switch content.colour {
        case .blue:
            return Color.blue
        case .green:
            return Color.green
        case .red:
            return Color.red
        }
    }

    // MARK: - Convert CardContent.Shapes to ShapeView
    
    var shape: ShapeView {
        return ShapeView(shape: content.shape)
    }
    
    struct ShapeView: Shape {
        var shape: CardContent.Shapes
        
        func path(in rect: CGRect) -> Path {
            switch shape {
            case .diamond:
                return Diamond().path(in: rect)
            case .circle:
                return Circle().path(in: rect)
            case .triangle:
                return Triangle().path(in: rect)
            }
            
        }
    }

    struct Diamond: Shape {
        func path(in rect: CGRect) -> Path {
            var p = Path()
            p.move(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            p.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            p.closeSubpath()
            return p
        }
    }

    struct Triangle: Shape {
        func path(in rect: CGRect) -> Path {
            var p = Path()
            p.move(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            p.closeSubpath()
            return p
        }
    }

}

// MARK: - Shading Modifier

struct ShadingModifier: ViewModifier {
    var type: CardContent.Shading

    func body(content: Content) -> some View {
        Group {
            if type == .solid {
                content
            } else if type == .stripped {
                StripePattern(stripeWidth: 2, interval: 2).mask(content)
            } else {
                content.opacity(0)
            }
        }
    }

}

extension View {
    func shading(type: CardContent.Shading) -> some View {
        self.modifier(ShadingModifier(type: type))
    }
}

// MARK: - Stripe Pattern

struct StripePattern: Shape {
    var stripeWidth: Int
    var interval: Int
    
    func path(in rect: CGRect) -> Path {
        let numberOfStripes = Int(rect.width) / stripeWidth
        
        var p = Path()
        p.move(to: rect.origin)
        for index in 0...numberOfStripes {
            if index % interval == 0 {
                p.addRect(CGRect(x: CGFloat(index * stripeWidth), y: 0, width: CGFloat(stripeWidth), height: rect.height))
            }
        }
        
        return p
    }
}

