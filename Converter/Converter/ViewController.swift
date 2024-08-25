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
    private let conversionService: ConversionServiceProtocol
    private let formatterService: FormatterServiceProtocol
    
    private var selectedFromUnit = 0
    private var selectedToUnit = 1
    
    // MARK: - IBOutlets

    @IBOutlet weak var unitType: UISegmentedControl!
    @IBOutlet weak var fromUnit: UITableView!
    @IBOutlet weak var toUnit: UITableView!
    @IBOutlet private weak var amount: UITextField!
    @IBOutlet private weak var result: UILabel!
    
    // MARK: - Initialization
    
    init(dataSource: ConversionDataSourceProtocol, conversionService: ConversionServiceProtocol, formatterService: FormatterServiceProtocol) {
        self.dataSource = dataSource
        self.conversionService = conversionService
        self.formatterService = formatterService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.dataSource = Conversion()
        self.conversionService = Converter()
        self.formatterService = Formatter()
        super.init(coder: coder)
    }
    
    // MARK: - IBActions
    
    @IBAction private func unitChanged(_ sender: Any) {
        selectedFromUnit = 0
        selectedToUnit = 1
        fromUnit.reloadData()
        toUnit.reloadData()
        updateResult()
    }
    
    @IBAction private func amountChanged(_ sender: Any) {
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
    
    private func updateResult() {
        guard let input = Double(amount.text ?? "") else {
            result.text = "Invalid input"
            return 
        }
        
        let conversion = dataSource.conversions[unitType.selectedSegmentIndex]
        let from = conversion.units[selectedFromUnit]
        let to = conversion.units[selectedToUnit]
        let output = conversionService.convert(input, from: from, to: to)
        result.text = formatterService.formatMeasurement(output)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.conversions[unitType.selectedSegmentIndex].units.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let conversion = dataSource.conversions[unitType.selectedSegmentIndex]
        let unit = conversion.units[indexPath.row]
        
        cell.textLabel?.text = formatterService.formatUnit(unit)
        cell.accessoryType = (tableView == fromUnit && indexPath.row == selectedFromUnit) || (tableView == toUnit && indexPath.row == selectedToUnit) ? .checkmark : .none
        return cell
    }
}

// MARK: - UITableViewDelegate
    
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableView == fromUnit ? "Convert from" : "Convert to"
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
