//
//  Formatter.swift
//  Converter
//
//  Created by Steven Hill on 21/08/2024.
//

import Foundation

protocol FormatterServiceProtocol {
    func formatUnit(_ unit: Dimension) -> String
    func formatMeasurement(_ measurement: Measurement<Dimension>) -> String
}

class Formatter: FormatterServiceProtocol {
    private let unitFormatter: MeasurementFormatter
    private let measurementFormatter: MeasurementFormatter
    
    init() {
        unitFormatter = MeasurementFormatter()
        unitFormatter.unitStyle = .long
        
        measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitOptions = .providedUnit
    }
    
    func formatUnit(_ unit: Dimension) -> String {
        return unitFormatter.string(from: unit).capitalized
    }
    
    func formatMeasurement(_ measurement: Measurement<Dimension>) -> String {
        return measurementFormatter.string(from: measurement)
    }
}
