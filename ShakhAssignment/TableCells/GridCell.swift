//
//  GridCell.swift
//  ShakhAssignment
//
//  Created by AKSHAY VAIDYA on 03/08/24.
//

import UIKit
import SDWebImage
import AVKit

class GridCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var videoArr = [Arr]()
    var index = 0
    var reelViewModel = ReelViewModel()
    var refreshDict = [Int:Bool]()
    @IBOutlet weak var videoCollectionView: UICollectionView!
    var mainIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        prepareCollection()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        videoCollectionView.layer.borderColor = UIColor.black.cgColor
        videoCollectionView.layer.borderWidth = 5
        videoCollectionView.backgroundColor = .black
        
    }
    
    func prepareCollection(){
        
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (videoCollectionView.frame.width - 20)/2 , height: 300)
        
        videoCollectionView.register(UINib(nibName: "videoCell", bundle: nil), forCellWithReuseIdentifier: "videoCell")
        videoCollectionView.isScrollEnabled = false
    }
    
    func setData(videoArr:[Arr], mainIndex:Int){
        
        self.videoArr = videoArr
        self.mainIndex = mainIndex
        videoCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! videoCell
        cell.reelViewModel = reelViewModel
        
        
        
        if indexPath.row == index &&  refreshDict[index] ?? true{
            
            cell.player.replaceCurrentItem(with: nil)
            
            cell.setData(model: videoArr[indexPath.row], index: mainIndex, index2: indexPath.row, id: "\(mainIndex)-\(indexPath.row)")
            
            refreshDict[index] = false
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6){ [self] in
                
                if index < (reelViewModel.reelDataList[reelViewModel.index].arr?.count ?? 0) - 1{
                    index = index + 1
                    
                }else{
                    
                    index = 0
                }
                
                refreshDict[index] = true
                cell.player.replaceCurrentItem(with: nil)
                videoCollectionView.reloadData()
                
            }
            
        }
        else{
            cell.videoImage.sd_setImage(with: URL(string: videoArr[indexPath.row].thumbnail ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            cell.player.replaceCurrentItem(with: nil)
        }
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (videoCollectionView.frame.width - 10)/2 , height: 300)
    }
    
}
