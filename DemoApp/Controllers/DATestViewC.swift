//
//  DATestViewC.swift
//  DemoApp
//
//  Created by Minakshi Bawa on 30/01/18.
//  Copyright © 2018 OrganisationName. All rights reserved.
//

import UIKit

class DATestViewC: DABaseViewC {
    
    //    MARK: - IBOutlets
    @IBOutlet weak var tblViewTest: UITableView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPerv: UIButton!
    @IBOutlet weak var viewResume: UIView!
    
    // MARK: - Variable Declaration
    var arrQuestions = [Question]()
    var ques = Question()
    var index = 0
    var timer = Timer()
    var counter = 0.0
    
    // MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK: - IBAction Methods -
    
    @IBAction func tapStatTimerBtn(_ sender: UIButton)
    {
        // stopping timer on click
        timer.invalidate()
        viewResume.isHidden = false
    }
    
    @IBAction func tapSubmitBtn(_ sender: UIButton)
    {
        // submit test, and calculate result
        self.calculateResult()
    }
    
    @IBAction func tapResumeBtn(_ sender: UIButton)
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DATestViewC.updateTime), userInfo: nil, repeats: true)
        viewResume.isHidden = true
    }
    
    @IBAction func tapNextBtn(_ sender: UIButton)
    {
        // show next question
        if index + 1  == arrQuestions.count
        {
            sender.isEnabled = false
            sender.setTitleColor(.lightGray, for: .normal)
        }
        else
        {
            // Enable previous button
            btnPerv.isEnabled = true
            btnPerv.setTitleColor(.black, for: .normal)
            
            
            // Increment index
            index += 1
            ques = arrQuestions[index]
            
            // Disable next button , if index become 10
            if index + 1 == arrQuestions.count
            {
                sender.isEnabled = false
                sender.setTitleColor(.lightGray, for: .normal)
            }
            else
            {
                sender.isEnabled = true
                sender.setTitleColor(.black, for: .normal)
            }
            self.tblViewTest.reloadData()
        }
    }
    @IBAction func tapPerviousBtn(_ sender: UIButton)
    {
        // show previous question
        if index == 0
        {
            sender.isEnabled = false
            sender.setTitleColor(.lightGray, for: .normal)
        }
        else
        {
            // enable next buttons
            btnNext.isEnabled = true
            btnNext.setTitleColor(.black, for: .normal)
            
            // decrement index by one
            index -= 1
            
            // Disable Previous Button, if index is zero now
            if index == 0 {
                sender.isEnabled = false
                sender.setTitleColor(.lightGray, for: .normal)
            } else {
                sender.isEnabled = true
                sender.setTitleColor(.black, for: .normal)
            }
            ques = arrQuestions[index]
            self.tblViewTest.reloadData()
        }
    }
    
    //MARK: -  Private Helper Methods -
    
    func configView()
    {
        // configure all view UI and initial setup
        viewResume.isHidden = true
        arrQuestions = PersistencyManager.shared.getQuestions()
        if arrQuestions.count > index
        {
            ques = arrQuestions[index]
        }
        else
        {
            self.showOkAlert(withMessage: kMSGNoData, andHandler: {
                self.navigationController?.popViewController(animated: true)
            })
        }
        self.tblViewTest.reloadData()
        btnPerv.setTitleColor(.lightGray, for: .normal)
        lblTimer.text = "00:00"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DATestViewC.updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime()
    {
        counter += 1
        let minutes = Int(counter) / 60 % 60
        let seconds = Int(counter) % 60
        
        // condition true only if exceeds 10 mins (600/60 = 10 mins)
        if counter == 600
        {
            self.showOkAlert(withMessage: "Time Up!!", andHandler: {
                self.calculateResult()
            })
        }
        lblTimer.text = String(format:"%02i:%02i", minutes, seconds)
    }
    
    func calculateResult()
    {
        var testResult = Result()
        testResult.totalNumberOfQuestions = arrQuestions.count
        
        // traverse each object of question to calculate result
        for question in arrQuestions
        {
            testResult.correctAns += ((question.isCorrect ?? false) ? 1 : 0)
            testResult.UnAnsweredQues += ((question.isAnswered ?? false) ? 0 : 1)
        }
        let data = arrQuestions[0]
        testResult.IncorrectAns  =   testResult.totalNumberOfQuestions - testResult.correctAns - testResult.UnAnsweredQues
        testResult.totalMarks = testResult.correctAns * (data.mark ?? 1) // as each question is of 1 mark
        self.pushResultView(withResultData: testResult)
    }
    
    func pushResultView(withResultData testResult: Result)
    {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let destViewC = sb.instantiateViewController(withIdentifier: "DAResultViewC") as! DAResultViewC
        destViewC.result = testResult
        self.navigationController?.pushViewController(destViewC, animated: true)
    }
}



//    MARK:- UITableView DataSource and Delegates -

extension DATestViewC: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // question cell
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellTblQues.identifier()) as! CellTblQues
            cell.lblQuestion.text = "Q\(index + 1): " + ques.ques
            cell.selectionStyle = .none
            return cell
        }
        else // Option cell
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellTblOption.identifier()) as! CellTblOption
            if ques.options.count >= indexPath.row
            {
                let dictForOptions = ques.options[indexPath.row - 1]
                cell.lblOptionTitle.text = String(describing: dictForOptions["title"]!)
                cell.imgViewSelction.image = ques.givenAnswerId == String(describing:dictForOptions[kId]) ? #imageLiteral(resourceName: "ac_radio") : #imageLiteral(resourceName: "de_radio")
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // update selected option's object in array
        if indexPath.row != 0
        {
            let arrOptions = ques.options
            let dict = arrOptions[indexPath.row - 1]
            ques.givenAnswerId = String(describing: dict[kId])
            ques.isAnswered = true
            ques.isCorrect = Int(dict[kId]!) == Int(ques.answersId) ? true : false
            arrQuestions[index] = ques
            print(arrQuestions[index])
            self.tblViewTest.reloadData()
        }
    }
    
}





