//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Steve Rickley on 5/24/22.
//

import Foundation

class RecipeModel: ObservableObject {
    
    //Declare variable to publish recipe changes
    @Published var recipes = [Recipe]()
    
    //Declare the initialize method
    init() {
        
        //Create instance of data service and get the data
        self.recipes = DataService.getLocalData()
    }
    
    // Get Portion
    static func getPortion(ingredient: Ingredient, recipeServings: Int, targetServings: Int) -> String {
        
        var portionOutput = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var wholePortions = 0
        
        if ingredient.num != nil {
            
            // Get a single serving size by multiplying denominator by the recipe servings
            denominator *= recipeServings
            
            // Get target portion by multiplying numerator by target servings
            numerator *= targetServings
            
            // Reduce fraction by greatest common divisor
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            
            // Get the whole portions if numberator greater than denominator
            if numerator >= denominator {
                
                // Calculated whole portions
                wholePortions = numerator / denominator
                
                // Calculate the remainder
                numerator = numerator % denominator
                
                // Assign to portion string
                portionOutput += String(wholePortions)
            }
            
            // Express remainder as a fraction
            if numerator > 0 {
                
                //Assign remainder as a fraction to the portion string
                portionOutput += wholePortions > 0 ? " ": ""
                portionOutput += "\(numerator)/\(denominator)"
                
            }
            
        }
        
        if var unit = ingredient.unit {
            
            // If we need to pluralize
            if wholePortions > 1 {
                
                // Calculate appropriate suffix
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                }
                else {
                    
                    unit += "s"
                    
                }
            }
            
            
            
            portionOutput += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            
            return portionOutput + unit
        }
        
        
        return portionOutput
        
    }
}
