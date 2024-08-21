//
//  Converter.swift
//  Converter
//
//  Created by Steven Hill on 21/08/2024.
//

import Foundation

protocol ConversionServiceProtocol {
    func convert(_ value: Double, from: Dimension, to: Dimension) -> Measurement<Dimension>
}

class Converter: ConversionServiceProtocol {
    func convert(_ value: Double, from: Dimension, to: Dimension) -> Measurement<Dimension> {
        let measurement = Measurement(value: value, unit: from)
        return measurement.converted(to: to)
    }
}
