//
//  PieChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartView : View {
    public var data: [PieChartData]
    public var title: String?
    public var legend: String?
    public var style: ChartStyle
    public var formSize:CGSize
    public var dropShadow: Bool
    public var valueSpecifier:String
    public var showBackground: Bool
    
    @State private var showValue = false
    @State private var currentValue: Double = 0 {
        didSet{
            if(oldValue != self.currentValue && self.showValue) {
                HapticFeedback.playSelection()
            }
        }
    }
    
    public init(data: [PieChartData], title: String? = nil, legend: String? = nil, style: ChartStyle = Styles.pieChartStyleOne, form: CGSize? = ChartForm.medium, dropShadow: Bool? = true, valueSpecifier: String? = "%.1f", showBackground: Bool = false){
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        self.formSize = form!
        if self.formSize == ChartForm.large {
            self.formSize = ChartForm.extraLarge
        }
        self.dropShadow = dropShadow!
        self.valueSpecifier = valueSpecifier!
        self.showBackground = showBackground
    }
    
    public var body: some View {
        ZStack{
            if (showBackground) {
                Rectangle()
                    .fill(self.style.backgroundColor)
                    .cornerRadius(20)
                    .shadow(color: self.style.dropShadowColor, radius: self.dropShadow ? 12 : 0)
            }
            
            VStack(alignment: .leading){
                HStack{
                    if(!showValue) {
                        if (self.title != nil) {
                        Text(self.title!)
                            .font(.headline)
                            .foregroundColor(self.style.textColor)
                        }
                    } else {
                        Text("\(self.currentValue, specifier: self.valueSpecifier)")
                            .font(.headline)
                            .foregroundColor(self.style.textColor)
                    }
                    Spacer()
                }.padding()
                
                PieChartRow(data: data, borderColor: self.style.accentColor, showValue: $showValue, currentValue: $currentValue)
                    .foregroundColor(self.style.accentColor)
                    .padding(self.legend != nil ? 0 : 12)
                    .offset(y:self.legend != nil ? 0 : -10)
                
                if(self.legend != nil) {
                    Text(self.legend!)
                        .font(.headline)
                        .foregroundColor(self.style.legendTextColor)
                        .padding()
                }
                
            }
        }.frame(width: self.formSize.width, height: self.formSize.height)
    }
}

#if DEBUG
struct PieChartView_Previews : PreviewProvider {
    static var previews: some View {
        let data = [PieChartData(value: 25, color: Color.orange), PieChartData(value: 30, color: Color.blue), PieChartData(value: 45, color: Color.green)]
        PieChartView(data: data, title: "Title", legend: "Legend")
        
        PieChartView(data: data, showBackground: true)
        
        PieChartView(data: data)
    }
}
#endif
