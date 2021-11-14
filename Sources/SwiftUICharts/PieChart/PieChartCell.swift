//
//  PieChartCell.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct PieSlice: Identifiable {
    var id = UUID()
    var startDeg: Double
    var endDeg: Double
    var value: Double
    var normalizedValue: Double
}

public struct PieChartCell : View {
    @State private var show:Bool = false
    var rect: CGRect
    var radius: CGFloat {
        return min(rect.width, rect.height)/2
    }
    var startDeg: Double
    var endDeg: Double
    var path: Path {
        var path = Path()
        path.addArc(center:rect.mid , radius:self.radius, startAngle: Angle(degrees: self.startDeg), endAngle: Angle(degrees: self.endDeg), clockwise: false)
        path.addLine(to: rect.mid)
        path.closeSubpath()
        return path
    }
    var index: Int
    var cellColor: Color
    var borderColor: Color
    public var body: some View {
        path
            .fill()
            .foregroundColor(self.cellColor)
            .overlay(path.stroke(self.borderColor, lineWidth: 2))
            .scaleEffect(self.show ? 1 : 0)
            .animation(Animation.spring().delay(Double(self.index) * 0.04))
            .onAppear(){
                self.show = true
        }
    }
}

extension CGRect {
    var mid: CGPoint {
        return CGPoint(x:self.midX, y: self.midY)
    }
}

#if DEBUG
struct PieChartCell_Previews : PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            PieChartCell(rect: geometry.frame(in: .local),startDeg: 0.0,endDeg: 90.0, index: 0, cellColor: Color.orange, borderColor: Color.white)
            }.frame(width:100, height:100)
        
    }
}
#endif
