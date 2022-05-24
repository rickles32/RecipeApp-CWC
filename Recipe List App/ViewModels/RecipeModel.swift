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
}
