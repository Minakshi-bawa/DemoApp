//
//  ViewController.swift
//  DemoApp
//
//  Created by Minakshi Bawa on 29/01/18.
//  Copyright © 2018 OrganisationName. All rights reserved.
//

import UIKit

let MAX_ROWS = 5
class DAResultViewC: UIViewController
{
    //MARK: - Variable declaration
    var result = Result()
    var arrTitles = [Dictionary<String,String>]()
    //MARK: - View LifeCycle Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.arrTitles = [[kTitle:"Total Number of Questions",kValue:"\(result.totalNumberOfQuestions)"],[kTitle:"Incorrect Answers", kValue: "\(result.IncorrectAns)"],[kTitle :"Unanswered Questions" , kValue: "\(result.UnAnsweredQues)"],[kTitle:"Correct Answers",kValue: "\(result.correctAns)" ],[kTitle:"Total Marks",kValue:"\(result.totalMarks)"]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        //MARK: - IBAction Methods -
    @IBAction func tapDoneBtn(_ sender: UIButton)
    {
       let arrNav =  self.navigationController!.viewControllers as [UIViewController]
        self.navigationController?.popToViewController(arrNav[arrNav.count - 3], animated: true)
    }
    
}

//    MARK:- UITableView DataSource and Delegates -

extension DAResultViewC: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  arrTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellTblResult.identifier()) as! CellTblResult
        let dictResult = arrTitles[indexPath.row]
        cell.lblType.text = dictResult[kTitle]
        cell.lblMarks.text = dictResult[kValue]
        cell.selectionStyle = .none
        return cell
    }
}

