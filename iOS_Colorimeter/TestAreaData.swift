import CoreData
import Foundation
import UIKit

@objc(TestArea)
class TestArea: NSManagedObject {
    @NSManaged var xcoordinate: String
    @NSManaged var ycoordinate: String
    @NSManaged var radius: String
    //@NSManaged var model: Model
}
