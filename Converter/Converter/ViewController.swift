//
//  ViewController.swift
//  Converter
//
//  Created by Steven Hill on 06/07/2024.
//
//  https://www.hackingwithswift.com/articles/110/build-a-unit-converter-for-tvos

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let dataSource: ConversionDataSourceProtocol
    
    var selectedFromUnit = 0
    var selectedToUnit = 1
    
    // MARK: - IBOutlets

    @IBOutlet weak var unitType: UISegmentedControl!
    @IBOutlet weak var fromUnit: UITableView!
    @IBOutlet weak var toUnit: UITableView!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var result: UILabel!
    
    // MARK: - Initialization
    
    init(dataSource: ConversionDataSourceProtocol) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.dataSource = Conversion()
        super.init(coder: coder)
    }
    
    // MARK: - IBActions
    
    @IBAction func unitChanged(_ sender: Any) {
        selectedFromUnit = 0
        selectedToUnit = 1
        fromUnit.reloadData()
        toUnit.reloadData()
        updateResult()
    }
    
    @IBAction func amountChanged(_ sender: Any) {
        updateResult()
    }
 
    // MARK: - Lifecycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUnitTypeSegmentedControl()
    }
    
    // MARK: - Setup Method
    
    private func setupUnitTypeSegmentedControl() {
        unitType.removeAllSegments()
        for (index, conversion) in dataSource.conversions.enumerated() {
            unitType.insertSegment(withTitle: conversion.title, at: index, animated: false)
        }
        unitType.selectedSegmentIndex = 0
    }
    
    // MARK: - Helper Method
    
    func updateResult() {
        let input = Double(amount.text ?? "") ?? 0.0
        
        let conversion = dataSource.conversions[unitType.selectedSegmentIndex]
        let from = conversion.units[selectedFromUnit]
        let to = conversion.units[selectedToUnit]
        let inputMeasurement = Measurement(value: input, unit: from)
        let output = inputMeasurement.converted(to: to)
        
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        result.text = formatter.string(from: output)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.conversions[unitType.selectedSegmentIndex].units.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .long
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let conversion = dataSource.conversions[unitType.selectedSegmentIndex]
        let unit = conversion.units[indexPath.row]
        
        cell.textLabel?.text = formatter.string(from: unit).capitalized
        
        if tableView == fromUnit {
            if indexPath.row == selectedFromUnit {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else if tableView == toUnit {
            if indexPath.row == selectedToUnit {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
    
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == fromUnit {
            return "Convert from"
        } else {
            return "Convert To"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == fromUnit {
            selectedFromUnit = indexPath.row
        } else {
            selectedToUnit = indexPath.row
        }
        tableView.reloadData()
        updateResult()
    }
}
