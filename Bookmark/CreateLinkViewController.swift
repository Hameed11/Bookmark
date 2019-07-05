//
//  CreateLinkViewController.swift
//  Bookmark
//
//  Created by Hameed Abdullah on 7/5/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit

class CreateLinkViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    
    var urlStr: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if titleTextField.text != "" && linkTextField.text != "" {
            
            saveData { (complete) in
                
                if complete {
                    dismiss(animated: true, completion: nil)
                    //self.tabBarController?.selectedIndex = 0
                    //performSegue(withIdentifier: "LinksViewController", sender: nil)
                }
            }
            
        }
    }
    
    //build a completion handler which is basically a function that we can pass a value to and whenever we call this function we can get that value whereever we call this fucn
    func saveData(completion: (_ finished: Bool) -> ()) {
        
        // setup the managed object context
        // this is how we get our managed object context from the main queue
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        
        let newLink = Link(context: managedContext)
        newLink.date = Date()
        newLink.title = titleTextField.text!
        
        guard let linkStr = linkTextField?.text else { return }
        urlStr = linkStr
        
        if urlStr.contains("https://") && urlStr.contains("http://") {
            urlStr = "http://\(urlStr!)"
            
            newLink.url = urlStr
        } else {
            
            
//            let alertControllr = UIAlertController(title: "?", message: "make sure the url is valied", preferredStyle: .actionSheet)
//
//            alertControllr.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            present(alertControllr, animated: true, completion: nil)
            
        }
        
        do {
            try managedContext.save()
            print("successfully saved")
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
        
    }

    
    //dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
   

}


































