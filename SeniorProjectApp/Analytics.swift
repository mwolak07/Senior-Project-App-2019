//
//  Analytics.swift
//  AnalyticsScreen
//
//  Created by Mateusz Wolak on 2/2/20.
//  Copyright © 2020 Mateusz Wolak. All rights reserved.
//

import Foundation


    private func category_checker(inputWord: String) -> [String] {
        if automotive.contains(inputWord.lowercased()) {
            return ["Automotive", inputWord.lowercased()]
        }
    
        else if bookstores.contains(inputWord.lowercased()) {
            return ["Bookstores", inputWord.lowercased()]
        }
    
        else if clothing.contains(inputWord.lowercased()) {
            return ["Clothing", inputWord.lowercased()]
        }
    
        else if electronics.contains(inputWord.lowercased()) {
            return ["Electronics", inputWord.lowercased()]
        }
    
        else if fuel.contains(inputWord.lowercased()) {
            return ["Fuel", inputWord.lowercased()]
        }
    
        else if hardware.contains(inputWord.lowercased()) {
            return ["Hardware", inputWord.lowercased()]
        }
    
        else if office_supply.contains(inputWord.lowercased()) {
            return ["Office Supplies", inputWord.lowercased()]
        }
    
        else if pharmacies.contains(inputWord.lowercased()) {
            return ["Pharmacies", inputWord.lowercased()]
        }
    
        else if sporting_goods.contains(inputWord.lowercased()) {
            return ["Sporting Goods", inputWord.lowercased()]
        }
    
        else if wholesale_clubs.contains(inputWord.lowercased()) {
            return ["Wholesale Clubs", inputWord.lowercased()]
        }
    
        else if groceries.contains(inputWord.lowercased()) {
            return ["Groceries", inputWord.lowercased()]
        }
    
        else if discount_stores.contains(inputWord.lowercased()) {
            return ["Discount/General Stores", inputWord.lowercased()]
        }
        
        else {
            return ["", ""]
        }
    }

    func analyze_text(inputText: String) {
        var words: [String] = []
        category = ""
        retailer = ""
        price = 0.0
        
        // Separating text block into array of lines and initializing words array
        let lines: [String] = inputText.components(separatedBy: "\n")

        // Separating lines into words and appending this array to words
        for line in lines {
            words += line.components(separatedBy: " ")
        }
        
        // Checking to see if any of the words describe a retailer and
        // setting category and retailer variables
        for word in words {
            var result = category_checker(inputWord: word)
            category = result[0]
            retailer = result[1]
        }
        
        // Category not found through simple filter, compensate for logos
        if category == "" {
            // Looking at the words with first and last few letters cut off
            for word in words {
                // Checking with first and last four cut off (with all smaller cuts)
                if word.count > 6 {
                    var firstFourCut = word.substring(from: word.index(word.startIndex, offsetBy: 4))
                    var lastFourCut = word.substring(from: word.index(word.endIndex, offsetBy: -4))
                    var firstThreeCut = word.substring(from: word.index(word.startIndex, offsetBy: 3))
                    var lastThreeCut = word.substring(from: word.index(word.endIndex, offsetBy: -3))
                    var firstTwoCut = word.substring(from: word.index(word.startIndex, offsetBy: 2))
                    var lastTwoCut = word.substring(from: word.index(word.endIndex, offsetBy: -2))
                    var firstOneCut = word.substring(from: word.index(word.startIndex, offsetBy: 1))
                    var lastOneCut = word.substring(from: word.index(word.endIndex, offsetBy: -1))
                    
                    var oneA = category_checker(inputWord: firstOneCut)
                    var oneB = category_checker(inputWord: lastOneCut)
                    var twoA = category_checker(inputWord: firstTwoCut)
                    var twoB = category_checker(inputWord: lastTwoCut)
                    var threeA = category_checker(inputWord: firstThreeCut)
                    var threeB = category_checker(inputWord: lastThreeCut)
                    var fourA = category_checker(inputWord: firstFourCut)
                    var fourB = category_checker(inputWord: lastFourCut)
                    
                    if oneA[0] != "" {
                        category = oneA[0]
                        retailer = oneA[1]
                    }
                    else if oneB[0] != "" {
                        category = oneB[0]
                        retailer = oneB[1]
                    }
                    else if twoA[0] != "" {
                        category = twoA[0]
                        retailer = twoA[1]
                    }
                    else if twoB[0] != "" {
                        category = twoB[0]
                        retailer = twoB[1]
                    }
                    else if threeA[0] != "" {
                        category = threeA[0]
                        retailer = threeA[1]
                    }
                    else if threeB[0] != "" {
                        category = threeB[0]
                        retailer = threeB[1]
                    }
                    else if fourA[0] != "" {
                        category = fourA[0]
                        retailer = fourA[1]
                    }
                    else if fourB[0] != "" {
                        category = fourB[0]
                        retailer = fourB[1]
                    }
                }
                    
                else if word.count > 5 {
                    var firstThreeCut = word.substring(from: word.index(word.startIndex, offsetBy: 3))
                    var lastThreeCut = word.substring(from: word.index(word.endIndex, offsetBy: -3))
                    var firstTwoCut = word.substring(from: word.index(word.startIndex, offsetBy: 2))
                    var lastTwoCut = word.substring(from: word.index(word.endIndex, offsetBy: -2))
                    var firstOneCut = word.substring(from: word.index(word.startIndex, offsetBy: 1))
                    var lastOneCut = word.substring(from: word.index(word.endIndex, offsetBy: -1))
                    
                    var oneA = category_checker(inputWord: firstOneCut)
                    var oneB = category_checker(inputWord: lastOneCut)
                    var twoA = category_checker(inputWord: firstTwoCut)
                    var twoB = category_checker(inputWord: lastTwoCut)
                    var threeA = category_checker(inputWord: firstThreeCut)
                    var threeB = category_checker(inputWord: lastThreeCut)
                    
                    if oneA[0] != "" {
                        category = oneA[0]
                        retailer = oneA[1]
                    }
                    else if oneB[0] != "" {
                        category = oneB[0]
                        retailer = oneB[1]
                    }
                    else if twoA[0] != "" {
                        category = twoA[0]
                        retailer = twoA[1]
                    }
                    else if twoB[0] != "" {
                        category = twoB[0]
                        retailer = twoB[1]
                    }
                    else if threeA[0] != "" {
                        category = threeA[0]
                        retailer = threeA[1]
                    }
                    else if threeB[0] != "" {
                        category = threeB[0]
                        retailer = threeB[1]
                    }
                }
                    
                else if word.count > 4 {
                    var firstTwoCut = word.substring(from: word.index(word.startIndex, offsetBy: 2))
                    var lastTwoCut = word.substring(from: word.index(word.endIndex, offsetBy: -2))
                    var firstOneCut = word.substring(from: word.index(word.startIndex, offsetBy: 1))
                    var lastOneCut = word.substring(from: word.index(word.endIndex, offsetBy: -1))
                    
                    var oneA = category_checker(inputWord: firstOneCut)
                    var oneB = category_checker(inputWord: lastOneCut)
                    var twoA = category_checker(inputWord: firstTwoCut)
                    var twoB = category_checker(inputWord: lastTwoCut)
                    
                    if oneA[0] != "" {
                        category = oneA[0]
                        retailer = oneA[1]
                    }
                    else if oneB[0] != "" {
                        category = oneB[0]
                        retailer = oneB[1]
                    }
                    else if twoA[0] != "" {
                        category = twoA[0]
                        retailer = twoA[1]
                    }
                    else if twoB[0] != "" {
                        category = twoB[0]
                        retailer = twoB[1]
                    }
                }
                    
                else if word.count > 3 {
                    var firstOneCut = word.substring(from: word.index(word.startIndex, offsetBy: 1))
                    var lastOneCut = word.substring(from: word.index(word.endIndex, offsetBy: -1))
                    
                    var oneA = category_checker(inputWord: firstOneCut)
                    var oneB = category_checker(inputWord: lastOneCut)
                    
                    if oneA[0] != "" {
                        category = oneA[0]
                        retailer = oneA[1]
                    }
                    else if oneB[0] != "" {
                        category = oneB[0]
                        retailer = oneB[1]
                    }
                }
            }
        }
        // Category and retailer have now been set
        
        // Beginning to find price
        // Split scraper output by $ and create array of possible prices
        let pricesSplit: [String] = inputText.components(separatedBy: "$")
        var possiblePrices: [Double] = []
        
        // Locating doubles after $ in text
        for priceString in pricesSplit {
            // Iterating over each post-$ section
            for i in 0...priceString.count {
                var priceIndex = priceString.index(priceString.startIndex, offsetBy: i)
                // Skip for . because it can still be part of double
                if priceString[priceIndex] == "." {
                    continue
                }
                // Character can be double, keep going
                else if let testChar = Double(String(priceString[priceIndex])) {
                    continue
                }
                // Non-double character encountered, stop counting and append to array
                else {
                    // Ensuring substring is of type double and appending (logic ensures this)
                    if var pricesSubstring = Double(priceString.substring(to: priceIndex)) {
                        possiblePrices.append(pricesSubstring)
                    }
                    break
                }
            }
        }
        // Assigning max possible price as price (logic ensures type is Double, but element must still be unwrapped)
        price = possiblePrices.max()!
        
        // Finding current date
        var date: String
        var dateTime = Date()
        var calendar = Calendar.current
        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
        ]
        
        let DateComponents = calendar.dateComponents(requestedComponents, from: dateTime)
        date = String(DateComponents.month!) + "/" + String(DateComponents.year!)
        
        // Adding the date and date price data to aggregate data
        // Date is in dates, add price to that month's aggregate data
        if dates.contains(date) {
            let dateIndex: Int = dates.firstIndex(of: date)!
            datesPrices[dateIndex] += price
        }
        // Date is not in dates, append the date to dates and price to datesPrices
        else {
            dates.append(date)
            datesPrices.append(price)
        }
        
        // Adding the retailer and retailer price data to aggregate data
        // Retailer is in retailers, add price to that retailer's aggregate data
        if retailers.contains(retailer) {
            let retailerIndex: Int = retailers.firstIndex(of: retailer)!
            retailersPrices[retailerIndex] += price
        }
        // Retailer is not in retailers, append the retailer to retailers and price to retailersPrices
        else {
            retailers.append(retailer)
            retailersPrices.append(price)
        }
        
        // Adding the category and category price data to aggregate data
        // Category is in categories, add price to that category's aggregate data
        if categories.contains(category) {
            let categoryIndex: Int = categories.firstIndex(of: category)!
            categoriesPrices[categoryIndex] += price
        }
        // Category is not in categorie, append the category to categories and price to categoriesPrices
        else {
            categories.append(category)
            categoriesPrices.append(price)
        }
        
        print(inputText)
        print(retailer)
        print(category)
        print(date)
        print(price)
    }
