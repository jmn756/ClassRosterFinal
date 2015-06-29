//
//  ViewController.swift
//  CFClassRoster
//
//  Created by Joey Nessif on 6/3/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class ClassRosterTableViewController: UITableViewController, DetailViewControllerDelegate, UINavigationControllerDelegate {
  
  var people = [Person]()
  
  func detailViewController(controller: DetailViewController){
    self.saveToArchive()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let peopleFromArchive = self.loadFromArchive() {
      self.people = peopleFromArchive
    } else {
      self.loadPeopleFromPlist()
      self.saveToArchive()
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.reloadData()
  }

  private func loadPeopleFromPlist() {
    
    if let peoplePath = NSBundle.mainBundle().pathForResource("people", ofType: "plist"),
      peopleObjects = NSArray(contentsOfFile: peoplePath) as? [[String : String]]
    {
      for object in peopleObjects {
        
        if let firstName = object["FirstName"],
          lastName = object["LastName"] {
            let person = Person(firstName: firstName, lastName: lastName)
            self.people.append(person)
        }
      }
    }
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("Persons", forIndexPath: indexPath)
            as! PersonCell
    
        cell.firstNameLabel.text = people[indexPath.row].firstName
        cell.lastNameLabel.text = people[indexPath.row].lastName
    
        if let image = people[indexPath.row].image {
          cell.customImage.image = image
        }
    
        cell.customImage.layer.cornerRadius = 20
        cell.customImage.layer.masksToBounds = true;
        cell.customImage.layer.borderWidth = 2
        cell.customImage.layer.borderColor = UIColor.greenColor().CGColor
    
    
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowPerson" {
      if let detailViewController = segue.destinationViewController as? DetailViewController {
        var selectedIndexPath = self.tableView.indexPathForSelectedRow()
        var selectedPerson = self.people[selectedIndexPath!.row]
        detailViewController.person = selectedPerson
        detailViewController.delegate = self
      }
    }
  }
  
  func saveToArchive() {
    
    if let archivePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last as? String {
      
      //let obj = NSKeyedArchiver.archivedDataWithRootObject(self.people)
      //NSKeyedArchiver.archiveRootObject(obj, toFile: archivePath + "/archive")
      NSKeyedArchiver.archiveRootObject(self.people, toFile: archivePath + "/archive")
    }
  }
  
  func loadFromArchive() -> [Person]? {
    
    if let archivePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last as? String {
      
      if let peopleFromArchive = NSKeyedUnarchiver.unarchiveObjectWithFile(archivePath + "/archive") as? [Person] {
        return peopleFromArchive
      }
      
    }
    return nil
    
  }
  
 
  
  func printPersons(source: String) {
    println("Source: " + source)
    for person in self.people {
        println(person.firstName + " " + person.lastName)
        println(person.image)
    }
    println("============================================")
  }
  
  
  
  
  
}

