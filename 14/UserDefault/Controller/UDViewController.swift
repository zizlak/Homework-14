
import UIKit

class UDViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBAction func changedName(_ sender: Any) {
        UserDefaultPersistance.shared.userName = nameTextField.text
        }


    @IBOutlet weak var familynameTextField: UITextField!
    @IBAction func changedFamilyname(_ sender: Any) {
          UserDefaultPersistance.shared.familyname = familynameTextField.text
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = UserDefaultPersistance.shared.userName
        familynameTextField.text = UserDefaultPersistance.shared.familyname
    }
}

extension UDViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true 
        
    }
}

