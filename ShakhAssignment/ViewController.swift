//
//  ViewController.swift
//  ShakhAssignment
//
//  Created by AKSHAY VAIDYA on 03/08/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var reelViewModel = ReelViewModel()
    
    @IBOutlet weak var listView: UITableView!
    var refreshDict = [Int:Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reelViewModel.prepareTable(tableView: listView)
        reelViewModel.getData(){
            
            self.listView.reloadData()
        }
      
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reelViewModel.reelDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GridCell", for: indexPath) as! GridCell
   
        reelViewModel.index = indexPath.row
        cell.reelViewModel = reelViewModel
  
        cell.setData(videoArr: reelViewModel.reelDataList[indexPath.row].arr ?? [], mainIndex: indexPath.row)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 630
    }
    
 

}


struct Media{
    
    var id:String
    var url:String
     var index:Int

}

struct File{
    
    var id:String
    var url:String
    
}
