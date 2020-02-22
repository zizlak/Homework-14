
import UIKit
import RealmSwift

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var categories: [Category] = []
    
    var index = 0
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = WeatherStorage.shared.actWeather ?? "No Internet"

        self.tableView.backgroundColor = UIColor.init(red: 0.1, green: 1, blue: 0.7, alpha: 0.2)
        self.tableView.reloadData()
        
        let loader1 = Loader1()
        
        loader1.load{(string) in
            DispatchQueue.main.async{
                if let string = string{
                    self.label.text = "\(string)"}
                else{self.label.text = WeatherStorage.shared.actWeather ?? "No Internet"}
                WeatherStorage.shared.actWeather = self.label.text
                
                self.index = 1
                self.tableView.reloadData()
            }
        }
    
        loader1.load5Days{categories in
            DispatchQueue.main.async{
                self.categories = categories
                
                self.tableView.reloadData()}
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if index == 0 {
            return WeatherStorage.shared.weather5date?.count ?? 0} else {
            return categories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellWeather") as! TableViewCell

        
        if index == 0 {
            cell.label1.text = WeatherStorage.shared.weather5date?[indexPath.row] ?? ""
            cell.label2.text = WeatherStorage.shared.weather5?[indexPath.row] ?? ""} else {
            
        let model = categories[indexPath.row]
        let kelvin: Double = model.main1["temp"]! as! Double
        let celsius: Int = Int(kelvin) - Int(273.15)
        cell.label1.text = model.dtTxt
        cell.label2.text = "Temperature: \(celsius)ºC\n" + "Pressure: \(model.main1["pressure"]!)\n" + "Humidity: \(model.main1["humidity"]!)\n" + "Wind speed: \(model.wind["speed"]!)m/s \n" + "\(model.weather[0]["main"]!)"

        }
        
        WeatherStorage.shared.weather5date = [cell.label1.text] as? [String]
        WeatherStorage.shared.weather5 = [cell.label2.text] as? [String]
        
        print(WeatherStorage.shared.weather5date ?? "")
        print(WeatherStorage.shared.weather5 ?? "")
        print(index)
       
        return cell
    }
}




