

import Foundation

class UserDefaultPersistance{
    static let shared = UserDefaultPersistance()
    
    private let kUserNameKey = "UserDefaultPersistance.kUserNameKey"
    private let kFamilynameKey = "UserDefaultPersistance.kFamilyname"
    
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey)}
        get { return UserDefaults.standard.string(forKey: kUserNameKey) }
    }
    var familyname: String?{
        set { UserDefaults.standard.set(newValue, forKey: kFamilynameKey)}
        get { return UserDefaults.standard.string(forKey: kFamilynameKey) }
    }
}
