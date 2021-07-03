//
//  Data+CoreDataProperties.swift
//  MyProject
//
//  Created by Emil Shukurov on 03/07/2021.
//
//

import Foundation
import CoreData


extension Data {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Data> {
        return NSFetchRequest<Data>(entityName: "Data")
    }

    @NSManaged public var name: String?

}

extension Data : Identifiable {

}
