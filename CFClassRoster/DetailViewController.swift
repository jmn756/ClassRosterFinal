//
//  DetailViewController.swift
//  CFClassRoster
//
//  Created by Joey Nessif on 6/14/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
  func detailViewController(controller: DetailViewController)
}

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

  var person = Person(firstName: "", lastName: "")
  
  @IBOutlet weak var firstNameText: UITextField!

  @IBOutlet weak var lastNameText: UITextField!
  
  @IBOutlet weak var imageView: UIImageView!
  
  weak var delegate: DetailViewControllerDelegate?
  
  override func viewDidLoad() {
      super.viewDidLoad()
      firstNameText.text! = person.firstName
      lastNameText.text! = person.lastName
      imageView.image = person.image
    
      // Do any additional setup after loading the view.
    
      self.firstNameText.delegate = self
      self.lastNameText.delegate = self
      self.firstNameText.tag = 0
      self.lastNameText.tag = 1
    }
  
  override func viewWillDisappear(animated: Bool) {
     super.viewWillDisappear(animated)
    delegate?.detailViewController(self)
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    if textField.tag == 0 {
      //set the first name
      self.person.firstName = textField.text
    } else {
      //set the last name
      self.person.lastName = textField.text
    }
  }
  
  @IBAction func photoButtonPressed(sender: AnyObject) {
    
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
       imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
    } else {
      imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    }
    imagePickerController.allowsEditing = true
    
    self.presentViewController(imagePickerController, animated: true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    
    if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
      self.imageView.image = image
      self.person.image = image
    }
    
   
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
