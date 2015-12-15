import CoreData
import Foundation
import UIKit

@objc(Model)
class Model: NSManagedObject {
    //properties feeding the attributes in our entity
    //Must match the entity attributes
    @NSManaged var modelName: String
    @NSManaged var testTime: String
    @NSManaged var intervalTime: String
    @NSManaged var rgb: DarwinBoolean
    @NSManaged var hsv: DarwinBoolean
    @NSManaged var kinetic: DarwinBoolean
    @NSManaged var endPoint: DarwinBoolean
    @NSManaged var calCompleted: DarwinBoolean
    @NSManaged var tracker: Int
    @NSManaged var testAreaInfo: String
    @NSManaged var testAreas: NSSet
    @NSManaged var units: String
    @NSManaged var flashOn: DarwinBoolean
    @NSManaged var flashOff: DarwinBoolean
    @NSManaged var slope: String
    @NSManaged var intercept: String
    //@NSManaged var testAreaName: String
}

extension Model {
    func addTestArea(value: TestArea) {
        self.mutableSetValueForKey("testAreas").addObject(value)
    }
    func getTestAreasAsArray() -> [TestArea] {
        var testAreas: [TestArea]
        testAreas = self.testAreas.allObjects as! [TestArea]
        return testAreas
    }
}

@objc(Model)
class TestInfo: NSManagedObject {
    //properties feeding the attributes in our entity
    //Must match the entity attributes
    @NSManaged var modelName: String
    @NSManaged var testAreaName: String
    @NSManaged var testAreaUnits: String
    @NSManaged var testNumber: String
}





