//
//  PersistencyManager.swift
//  DemoApp
//
//  Created by Minakshi Bawa on 30/01/18.
//  Copyright © 2018 OrganisationName. All rights reserved.
//

import Foundation
final class PersistencyManager {
    // 1
    static let shared = PersistencyManager()
    // Initializer
    private init() {
        
    }
    
    func getQuestions() -> [Question]
    {
        let path = Bundle.main.path(forResource: "QuestionList", ofType: ".json")
        let url = URL(fileURLWithPath: path ?? "")
        var questionData =  [Question]()
        let data = try! Data(contentsOf:url)
                    do
                    {
                        let quesData = try JSONDecoder().decode([Question].self, from: data)
                       questionData = quesData
                    }
                    catch let jsonErr {
                        print("Error serializing json:", jsonErr.localizedDescription)
                }
        return questionData
        
    }
    
}


