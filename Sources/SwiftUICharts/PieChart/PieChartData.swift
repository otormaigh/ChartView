//
//  File.swift
//  
//
//  Created by Fred on 14/11/2021.
//

import Foundation
import SwiftUI

public struct PieChartData {
    let value: Double
    let color: Color
    
    public init(value: Double, color: Color) {
        self.value = value
        self.color = color
    }
}