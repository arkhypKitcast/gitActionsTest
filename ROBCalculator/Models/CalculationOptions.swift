//
//  CalculationOptions.swift
//  ROBCalculator
//
//  Created by arkhyp on 13.04.2022.
//

import Foundation

let currencySymbol = "$"

public class CalculationOptions {
    public var operating: Bool = false
    public var ownership : Bool = false
    public var financing: Bool = false
    
    init(operating: Bool,
         ownership : Bool,
         financing: Bool) {
        
        self.operating = operating
        self.ownership = ownership
        self.financing = financing
    }
    
    var questions: [Question] {
         return operatingQuestion + ownershipQuestion + financingQuestion
    }
    
    var operatingQuestion: [Question] {
        return [
            DoubleQuestion(key: "",
                           title: "The price for a gallon of jet fuel?",
                           placeholder: "6.53",
                           qDescription: nil,
                           value: nil,
                           measure: currencySymbol),
            DoubleQuestion(key: "",
                           title: "The average fuel consumption for aircraft?",
                           placeholder: "9",
                           qDescription: "In gallons/hour",
                           value: nil,
                           measure: "gal/hr"),
            DoubleQuestion(key: "",
                           title: "The cost per oil change?",
                           placeholder: "273.32",
                           qDescription: "Oil analysis, parts and labor",
                           value: nil,
                           measure: currencySymbol),
            DoubleQuestion(key: "",
                           title: "Hours between oil changes?",
                           placeholder: "50",
                           qDescription: nil,
                           value: nil,
                           measure: "hrs."),
            DoubleQuestion(key: "",
                           title: "The average oil consumption for aircraft?",
                           placeholder: "0.67",
                           qDescription: nil,
                           value: nil,
                           measure: "qt/hr"),
            DoubleQuestion(key: "",
                           title: "The cost for a quart of oil?",
                           placeholder: "7.9",
                           qDescription: nil,
                           value: nil,
                           measure: currencySymbol),
            DoubleQuestion(key: "",
                           title: "How much does a factory overhaul cost for this engine?",
                           placeholder: "21000",
                           qDescription: nil,
                           value: nil,
                           measure: currencySymbol),
            DoubleQuestion(key: "",
                           title: "What is the factory recommended time between engine overhaul?",
                           placeholder: "1200",
                           qDescription: nil,
                           value: nil,
                           measure: "hrs."),
        ]
    }
    
    var ownershipQuestion: [Question] {
        return [
            DoubleQuestion(key: "",
                           title: "The price for annual insurance?",
                           placeholder: "1200",
                           qDescription: nil,
                           value: nil,
                           measure: currencySymbol),
            DoubleQuestion(key: "",
                           title: "The monthly hanger or Tie Down Costs?",
                           placeholder: "50",
                           qDescription: nil,
                           value: nil,
                           measure: currencySymbol),
            DoubleQuestion(key: "",
                           title: "The average cost for annual inspection plus any misc. unscheduled maintenance during the year?",
                           placeholder: "1500",
                           qDescription: "Cost can very. Be realistic, or plan for the worst case scenario.",
                           value: nil,
                           measure: currencySymbol),
            DoubleQuestion(key: "",
                           title: "Annual subscription costs for avionics databases?",
                           placeholder: "500",
                           qDescription: "For example Garmin/Sandel/Avidyne",
                           value: nil,
                           measure: currencySymbol),
            DoubleQuestion(key: "",
                           title: "Annual taxes and registration fee?",
                           placeholder: "255",
                           qDescription: "For the USA 0.005 of value + 5.00",
                           value: nil,
                           measure: currencySymbol),
        ]
    }
    
    var financingQuestion: [Question] {
        return [
            DoubleQuestion(key: "",
                           title: "The price of the aircraft?",
                           placeholder: "180000",
                           qDescription: nil,
                           value: nil,
                           measure: currencySymbol),
            DoubleQuestion(key: "",
                           title: "Money down?",
                           placeholder: "80000",
                           qDescription: nil,
                           value: nil,
                           measure: currencySymbol),
            DoubleQuestion(key: "",
                           title: "What is the loan interest rate?",
                           placeholder: "2",
                           qDescription: nil,
                           value: nil,
                           measure: "%"),
            DoubleQuestion(key: "",
                           title: "How many years is the loan for?",
                           placeholder: "12",
                           qDescription: nil,
                           value: nil,
                           measure: "yrs."),
        ]
    }
}
