//
//  videoCell.swift
//  ShakhAssignment
//
//  Created by AKSHAY VAIDYA on 03/08/24.
//

import UIKit
import AVKit
import SDWebImage

class videoCell: UICollectionViewCell {
    
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    var reelViewModel = ReelViewModel()
    
    @IBOutlet weak var videoImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        
        contentView.backgroundColor = .white
    }
    
    func setData(model:Arr, index:Int, index2:Int, id:String){
        
        if reelViewModel.fileDict[id] == nil{
      
            reelViewModel.refreshDict[id] = (reelViewModel.refreshDict[id] ?? 0) + 1
            videoImage.sd_setImage(with: URL(string:  ""), placeholderImage: UIImage(named: "loading.png"))
            
            guard let videoURL = URL(string: model.video ?? "") else {return}
            
            DispatchQueue.global().async { [self] in
                
                if (reelViewModel.refreshDict[id] ?? 0) < 2{
                    let data = try? Data(contentsOf: videoURL)
                    
                    DispatchQueue.main.async{
                        
                        if data != nil{
                            self.addToFile(data: data ?? Data(), id: id, index: index, index2: index2)
                        }
                        else{
                            self.reelViewModel.refreshDict[id] = 0
                        }
                    }
                }
                
            }
            print("")
            
        }
        else{
        
            
            let videoPath = reelViewModel.fileDict[id] ?? ""
            
            if let url = URL(string: videoPath){
                //
                DispatchQueue.main.async{
                    self.videoImage.sd_setImage(with: URL(string:  ""))
                    self.setVideo(url: url)
                
                }
            }
        }
        print(reelViewModel.index)
        
        
        
    }
    
    
    func setVideo(url:URL){
        
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = bounds
        playerLayer.videoGravity = .resizeAspect
        self.layer.addSublayer(playerLayer)
        
        player.rate = 2
        player.play()
        
    }
    
    func addToFile(data:Data,id:String, index:Int, index2:Int){
        
        let fileUrl = FileManager.default
        
        
        let videoData = data
        let docDir = try! fileUrl.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let appFolder = docDir.appendingPathComponent("Folder1")
        try? fileUrl.createDirectory(at: appFolder, withIntermediateDirectories: true, attributes: [:])
        
        let videoURL = appFolder.appendingPathComponent("\(id).mp4")
        
        
        try? videoData.write(to: videoURL)
   
        reelViewModel.fileDict[id] = videoURL.absoluteString
        print(videoURL)
        
    }
    
}
