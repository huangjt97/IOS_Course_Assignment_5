//
//  ViewController.swift
//  StarWarWiki
//
//  Created by Jacky Huang on 11/17/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var PeopleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON{
            self.PeopleTable.reloadData()
            print("success")
        }
        
        PeopleTable.delegate   = self
        PeopleTable.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    var people = [PeopleModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let p = people[indexPath.row]
        cell.textLabel?.text = p.name.capitalized
        cell.textLabel?.textColor = UIColor.yellow
        return cell
    }
    
    func downloadJSON(completed: @escaping() -> ()) {
        let PeopleURL = URL(string: "https://swapi.py4e.com/api/people/1")
        
        URLSession.shared.dataTask(with: PeopleURL!) { (data, response, err) in
            if err == nil {
                guard let data = data else { return }
                
                do {
                    self.people = try JSONDecoder().decode([PeopleModel].self, from: data)
                }
                catch {
                    print("cant get data")
                }
                /*
                do {
                    self.people = try JSONDecoder().decode([PeopleModel].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                    print(self.people[0])
                }
                catch {
                    print("Error fetching data from api")
                }*/
                
            } else {
                print("Error")
            }
        }.resume()
    }

}

