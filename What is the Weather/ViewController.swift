//
//  ViewController.swift
//  What is the Weather
//
//  Created by Abdallah Eid on 10/23/17.
//  Copyright © 2017 TripleApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var cityText: UITextField!
    
    @IBOutlet var weatherNews: UILabel!
    
    @IBAction func submit(_ sender: Any) {
    
        if let url = URL(string: "https://www.weather-forecast.com/locations/" + cityText.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
            
            let request = NSMutableURLRequest(url:url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                
                data, response, error in
                
                var message = ""
                
                if error != nil {
                    
                    print(error!)
                    
                } else {
                    
                    if let unwrappedData = data {
                        
                        let dataString = NSString(data: unwrappedData , encoding: String.Encoding.utf8.rawValue)
                        
                        let stringSeperator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                        if let contentArray = dataString?.components(separatedBy: stringSeperator) {
                            
                            if contentArray.count > 0 {
                                
                                let stringSeperator2 = "</span>"
                                
                                let newContentArray = contentArray[1].components(separatedBy: stringSeperator2)
                                
                                if newContentArray.count > 0 {
                                    
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    
                                    print(message)
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                if message == "" {
                    
                    message = "The weather there couldn't be found, please try again"
                    
                }
                
                DispatchQueue.main.sync(execute: {
                    
                    self.weatherNews.text = message
                    
                })
                
                
            }
            
            task.resume()
            
        } else {
            
            self.weatherNews.text = "The weather there couldn't be found, please try again"
            
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }

}

