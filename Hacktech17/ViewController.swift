//
//  ViewController.swift
//  Hacktech17
//
//  Created by KirillDubovitskiy on 3/5/17.
//  Copyright © 2017 BrainDump. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let translateAPIManager = TranslateAPIManager.shared
    
    @IBOutlet weak var sourceTextField: UITextView!
    @IBOutlet weak var processedTextField: UITextView!
    
    @IBOutlet weak var difficultyLevelSlider: UISlider!
    
    
    @IBAction func translateButtonPressed(_ sender: Any) {
        let difficulty = Double(difficultyLevelSlider.value)
        
        translateAPIManager.translate(text: sourceTextField.text, targetLanguage: "ru", difficulty: difficulty)
            .then { (traslation) -> Void in
                DispatchQueue.main.async {
                    self.processedTextField.text = traslation
                }
            }.catch { (error) in
                print("unhandled error \(error)")
        }
    }

}

