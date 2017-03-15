//
//  ViewController.swift
//  MapQuiz
//
//  Created by Rael Kenny on 2/16/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    override var canBecomeFirstResponder: Bool { return true }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            wrong = 0
            correct = 0
            showCurrentQuestion()
        }
    }
    
    //User Defaults => dictionary that saves to the device (stores information after you turn the app off)
    var defaults = UserDefaults.standard
    
    
    var questions = [MapQuestion]()
    var currentQuestionIndex: Int {
        get {
            //if the key doesnt exist -> returns 0
            return defaults.integer(forKey: "currentQuestions")
        }
        set {
            defaults.set(newValue, forKey: "currentQuestions")
        }
    }
    
    var currentQuestion: MapQuestion {
        return questions[currentQuestionIndex]
    }
    
    var correct: Int {
        get {
            //if the key doesnt exist -> returns 0
            return defaults.integer(forKey: "correctAnswers")
        }
        set {
            defaults.set(newValue, forKey: "correctAnswers")
        }
    }
    
    var wrong: Int {
        get {
            //if the key doesnt exist -> returns 0
            return defaults.integer(forKey: "wrongAnswers")
        }
        set {
            defaults.set(newValue, forKey: "wrongAnswers")
        }
    }
    
    
    //output
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    @IBOutlet weak var mapView: MKMapView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        mapView.mapType = .satellite
        
        showCurrentQuestion()
        
    }
    
    
    //actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        guard let answer = sender.titleLabel?.text
            else {return}
        
        guard let isCorrect = currentQuestion.answers[answer]
            else { return }
        
        var title = " "
        var subtitle = " "
        
        if isCorrect {
            correct += 1
            title = "Correct"
            subtitle = "You're so good at geography!"
        } else {
            wrong += 1
            title = "Wrong"
            subtitle = "Try again!"
        }
        
        
        //1. make an alert controller (the pop up)
        //2. create an action to it (triggered when you tap "ok")
        //3. add the action to the alert controller
        //4. present the controller
        
        let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert) //1
        let action = UIAlertAction(title: "OK", style: .default) { (action) in //2
        //everything we want to do after "OK" is pressed
            
            if self.currentQuestionIndex < self.questions.count - 1 {
                self.currentQuestionIndex += 1
            } else {
                self.currentQuestionIndex = 0
            }
            
            self.showCurrentQuestion()
            
        }
        
        alertController.addAction(action) //3
        
        self.present(alertController, animated: true, completion: nil) //4
        
        
        
    }

    func showCurrentQuestion() {
        self.score.text = "Correct: \(correct) Wrong: \(wrong)"
        let question = questions[currentQuestionIndex]
        //to display the question:
        //1. display correct location on map
        //2. create MKCoordinateRegion
        //3. set the map to that region to start
        //4. set buttons to having answers
        //5. get the different answers
        //6. put answers in the buttons
        
        
        let region = MKCoordinateRegionMakeWithDistance(question.location, question.regionSizeInMeters, question.regionSizeInMeters)
        mapView.setRegion(region, animated: true) //1.2.3
        
        
        let answers = [String](question.answers.keys) //5
        guard answers.count == 3
            else { return }
        
        self.answerOne.setTitle(answers[0], for: .normal) //6
        self.answerTwo.setTitle(answers[1], for: .normal)
        self.answerThree.setTitle(answers[2], for: .normal)
        
        
    }
    
    
    func loadData() {
        let kb = MapQuestion(location: CLLocationCoordinate2D(latitude:   67.074411, longitude:-158.945477), regionSizeInMeters: 1000)
        kb.addAnswer("Alaska", isCorrect: true)
        kb.addAnswer("Sahara Desert", isCorrect: false)
        kb.addAnswer("Arizona", isCorrect: false)
        self.questions.append(kb)
        
        let ba = MapQuestion(location: CLLocationCoordinate2D(latitude: 44.499527, longitude: 33.598420), regionSizeInMeters: 500)
        ba.addAnswer("Turkey", isCorrect: false)
        ba.addAnswer("Russia", isCorrect: true)
        ba.addAnswer("Italy", isCorrect: false)
        self.questions.append(ba)
        
        let ca = MapQuestion(location: CLLocationCoordinate2D(latitude: 32.675831, longitude:-117.157526), regionSizeInMeters: 500)
        ca.addAnswer("California", isCorrect: true)
        ca.addAnswer("Germany", isCorrect: false)
        ca.addAnswer("Italy", isCorrect: false)
        self.questions.append(ca)
        
        let ar = MapQuestion(location: CLLocationCoordinate2D(latitude: -33.867886, longitude:-63.984500), regionSizeInMeters: 1500)
        ar.addAnswer("Tennessee", isCorrect: false)
        ar.addAnswer("Argentina", isCorrect: true)
        ar.addAnswer("New Mexico", isCorrect: false)
        self.questions.append(ar)
        
        let ch = MapQuestion(location: CLLocationCoordinate2D(latitude: 40.452107, longitude: 93.742118), regionSizeInMeters: 2500)
        ch.addAnswer("Peru", isCorrect: false)
        ch.addAnswer("China", isCorrect: true)
        ch.addAnswer("Egypt", isCorrect: false)
        self.questions.append(ch)
        
        let nv = MapQuestion(location: CLLocationCoordinate2D(latitude: 37.563936, longitude: -116.851230), regionSizeInMeters: 500)
        nv.addAnswer("Nevada", isCorrect: true)
        nv.addAnswer("China", isCorrect: false)
        nv.addAnswer("Egypt", isCorrect: false)
        self.questions.append(nv)
        
        let sa = MapQuestion(location: CLLocationCoordinate2D(latitude: 16.864841, longitude:  11.953808), regionSizeInMeters: 500)
        sa.addAnswer("Sahara Desert", isCorrect: true)
        sa.addAnswer("Nevada", isCorrect: false)
        sa.addAnswer("Egypt", isCorrect: false)
        self.questions.append(sa)
        
        
        let bs = MapQuestion(location: CLLocationCoordinate2D(latitude: 26.357896, longitude: 127.783809), regionSizeInMeters: 200)
        bs.addAnswer("Japan", isCorrect: true)
        bs.addAnswer("New York", isCorrect: false)
        bs.addAnswer("Tibet", isCorrect: false)
        self.questions.append(bs)
    }
    
    
    
}

