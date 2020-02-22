import UIKit
import CoreData

class ToDo2_TableViewController: UITableViewController {
    
    var toDoItems: [Task] = []
    
    // MARK: - addButton
    @IBAction func addTask(_ sender: UIBarButtonItem) {
    
        let ac = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) {action in
            let textField = ac.textFields?[0]
            if textField!.text?.isEmpty == false {
                self.saveTask(taskToDo: (textField?.text)! )
                self.tableView.reloadData()}
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        ac.addTextField{
            textField in
        }
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    
    // MARK: - saveTask
    func saveTask(taskToDo: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Task
        taskObject.taskToDo = taskToDo
        do {
            try context.save()
            toDoItems.insert(taskObject, at: toDoItems.count)
        } catch {
            print(error.localizedDescription)
        }
    }

    override func viewWillAppear(_ animated: Bool){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do{
            toDoItems = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)

        cell.textLabel?.text = toDoItems[indexPath.row].taskToDo
        
        return cell
}
    
    
        // MARK: - deleteAction
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deletAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let taskToDelete = self.toDoItems[indexPath.row]
            context.delete(taskToDelete)
            do {try context.save()
            
            self.toDoItems.remove(at: indexPath.row)
   
            tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()} catch let error as NSError {
                    print("Delete error\(error). : \(error.userInfo)")
            }
        }
        
        return [deletAction]
        
    }
}


    

