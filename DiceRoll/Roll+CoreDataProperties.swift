//
//  Roll+CoreDataProperties.swift
//  DiceRoll
//
//  Created by Tino on 10/4/21.
//
//

import Foundation
import CoreData


extension Roll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Roll> {
        return NSFetchRequest<Roll>(entityName: "Roll")
    }

    @NSManaged public var results: Data?
    @NSManaged public var sides: Int16
    @NSManaged public var rolls: Int16
    @NSManaged public var index: Int16
    @NSManaged public var total: Int16

    var wrappedResults: [Int] {
        guard let results = results else { return [] }
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Int].self, from: results)
            return decodedData
        } catch {
            print("Unresolved error \(error.localizedDescription)")
        }
        return []
    }
}

extension Roll : Identifiable {

}
