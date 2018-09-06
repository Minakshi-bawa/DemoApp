//
//  Question.swift
//  DemoApp
//
//  Created by Minakshi Bawa on 29/01/18.
//  Copyright © 2018 OrganisationName. All rights reserved.
//

import Foundation

struct Question:Decodable
{
    var ques:String
    var id:String
    var answersId:String
    var options:[Dictionary<String,String>]
    var isAnswered : Bool?
    var givenAnswerId : String?
    var isCorrect:Bool?
    var mark:Int?
    init() {
         ques = String()
         id = String()
         answersId = String()
         options = [Dictionary<String,String>]()
        isAnswered = false
        givenAnswerId = String()
        isCorrect = false
        mark = 1
    }
}

struct Result
{
    var totalNumberOfQuestions:Int
    var correctAns : Int
    var IncorrectAns : Int
    var UnAnsweredQues : Int
    var totalMarks:Int
    init() {
        totalNumberOfQuestions = 0
        correctAns = 0
        IncorrectAns = 0
        UnAnsweredQues = 0
        totalMarks = 0
    }
}
