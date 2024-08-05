//
//  ReelViewModel.swift
//  ShakhAssignment
//
//  Created by AKSHAY VAIDYA on 03/08/24.
//

import Foundation
import UIKit

class ReelViewModel{
    
    var reelDataList = [Reel]()
    var index = 0
    var refreshDict = [String:Int]()
    var fileDict = [String:String]()
    
    
    func getData(comp:(()->())? = nil){
        
        guard let fileUrl = Bundle.main.url(forResource: "reels", withExtension: "json") else {return}
        
        do {
            let data = try Data(contentsOf: fileUrl)
            
            let jsonData = try? JSONDecoder().decode(ReelModel.self, from: data)
            
            reelDataList = jsonData?.reels ?? []
            
            comp?()
        }
        
        catch{
            
            print(error.localizedDescription)
        }
    
        
    }
    
    
    func prepareTable(tableView:UITableView){
        tableView.separatorColor = .clear
        tableView.register(UINib(nibName: "GridCell", bundle: nil), forCellReuseIdentifier: "GridCell")
        
    }
}
