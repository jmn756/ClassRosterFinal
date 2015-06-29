//
//  Person.swift
//  CFClassRoster
//
//  Created by Joey Nessif on 6/14/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
  var firstName : String
  var lastName : String
  var image : UIImage?
  
  init (firstName: String, lastName: String){
    self.firstName = firstName
    self.lastName = lastName
    //self.image = UIImage(named: "png_floating_terrain_by_moonglowlilly-d5qb58m.png")!
    self.image = UIImage(named: "download-images-of-gentle-dogs-6866.jpg")!
  }
  
  required init(coder aDecoder: NSCoder) {
    self.firstName = aDecoder.decodeObjectForKey("firstName") as! String
    self.lastName = aDecoder.decodeObjectForKey("lastName") as! String
    self.image = aDecoder.decodeObjectForKey("image") as? UIImage
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.firstName, forKey: "firstName")
    aCoder.encodeObject(self.lastName, forKey: "lastName")
    //let data = UIImagePNGRepresentation(self.image);
    //aCoder.encodeObject(data, forKey: "image")
    aCoder.encodeObject(self.image, forKey: "image")
  }
    
}
