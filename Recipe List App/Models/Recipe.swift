//
//  Recipe.swift
//  Recipe List App
//
//  Created by Steve Rickley on 5/24/22.
//

import Foundation

class Recipe: Identifiable, Decodable {
    
    //Create the properties of the class based on the JSON contents
    var id:UUID?
    var name:String
    var featured:Bool
    var image:String
    var description:String
    var prepTime:String
    var cookTime:String
    var totalTime:String
    var servings:Int
    var ingredients:[String]
    var directions:[String]
    
}
