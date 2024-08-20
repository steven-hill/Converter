//
//  Conversion.swift
//  Converter
//
//  Created by Steven Hill on 20/08/2024.
//

import Foundation

protocol ConversionDataSourceProtocol {
    var conversions: [(title: String, units: [Dimension])] { get }
}

class Conversion: ConversionDataSourceProtocol {
    let conversions: [(title: String, units: [Dimension])] = [
        ("Distance", [UnitLength.astronomicalUnits, UnitLength.centimeters, UnitLength.feet, UnitLength.inches, UnitLength.kilometers, UnitLength.lightyears, UnitLength.meters, UnitLength.miles, UnitLength.millimeters, UnitLength.parsecs, UnitLength.yards]),
        ("Duration", [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]),
        ("Mass", [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds, UnitMass.stones, UnitMass.metricTons]),
        ("Temperature", [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]),
        ("Volume", [UnitVolume.bushels, UnitVolume.cubicFeet, UnitVolume.cups, UnitVolume.fluidOunces, UnitVolume.gallons, UnitVolume.liters, UnitVolume.milliliters, UnitVolume.pints, UnitVolume.quarts, UnitVolume.tablespoons, UnitVolume.teaspoons]),
    ]
}
