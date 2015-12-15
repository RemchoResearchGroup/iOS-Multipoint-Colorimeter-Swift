import CoreData
import Foundation
import UIKit

@objc(TestArea)
class TestArea: NSManagedObject {
    @NSManaged var xcoordinate: String
    @NSManaged var ycoordinate: String
    @NSManaged var radius: String
    @NSManaged var name: String
    @NSManaged var units: String
    @NSManaged var slope: String
    @NSManaged var intercept: String
}
