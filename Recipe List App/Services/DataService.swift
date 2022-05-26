//
//  DataService.swift
//  Recipe List App
//
//  Created by Steve Rickley on 5/24/22.
//

import Foundation

class DataService {
    
    static func getLocalData() -> [Recipe] {
        
        //Parse local json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        //Check if pathString is not nil, otherwise return an empty recipe list
        guard pathString != nil else {
            return [Recipe]()
        }
        
        //Create a url object
        let url = URL(fileURLWithPath: pathString!)
        
        //Create a data object
        do {
            let data = try Data(contentsOf: url)
            
            //Decode the data with a json decoder
            let decoder = JSONDecoder()
            
            do {
                let recipeData = try decoder.decode([Recipe].self, from: data)
                
                //Add the unique Ids
                for r in recipeData {
                    r.id = UUID()
                    
                    //Add unique IDs to recipe ingredients
                    for i in r.ingredients {
                        i.id = UUID()
                    }
                }
                
                //Return the recipes
                return recipeData
            }
            catch{
                //Error with parsing json
                print(error)
            }
        }
        catch {
            //Print the error with getting data if one occurs
            print(error)
        }
        
        return [Recipe]()
    }
    
}
