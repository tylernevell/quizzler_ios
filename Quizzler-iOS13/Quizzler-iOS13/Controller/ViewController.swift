//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Tyler Nevell on 3/15/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

// Controller is responsible for telling the other components what to do. It is also responsible
// for responding to changes in other components. Should handle what to do with user interaction from
// view and tell the view what to display. Should also fetch relevant data from the model to send
// to the screen and tell the model to update itself.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    @IBOutlet weak var choice3Button: UIButton!
    
    var quizBrain = QuizBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle! // True, False
        // ask QuizBrain is answer is correct
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
        
        // check to see if user's answer is correct with actual answer found in quiz 2d array
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        quizBrain.nextQuestion()
        
        // timer gives background color a split second to display to user whether or not they're correct
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        
        choice1Button.setTitle(quizBrain.getAnswerText(0), for: .normal)
        choice2Button.setTitle(quizBrain.getAnswerText(1), for: .normal)
        choice3Button.setTitle(quizBrain.getAnswerText(2), for: .normal)
        
        progressBar.progress = quizBrain.getProgress()
        
        choice1Button.backgroundColor = UIColor.clear
        choice2Button.backgroundColor = UIColor.clear
        choice3Button.backgroundColor = UIColor.clear
        
        scoreLabel.text = "Score: \(quizBrain.getScore())"
    }
    
}

