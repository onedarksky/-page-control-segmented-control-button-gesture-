//
//  ViewController.swift
//  利用 page control，segmented control，button & gesture 更換內容
//
//  Created by Jiang Yung Tse on 2021/11/4.
//

import UIKit
import AVFoundation

//陣列
let FoodImages = ["Japanese Curry Udon","Japanese Curry With G-Chop","Korean Fried Fillet With Rice","Thai Fried Fillet With Rice","Mushroom Bolognese","Mushroom Carbonara"]
 
let FoodLables = ["Japanese Curry Udon\n日式咖哩烏冬","Japanese Curry With G-Chop\n日式咖哩雞排飯","Korean Fried Fillet With Rice\n韓式炸雞飯","Thai Fried Fillet With Rice\n泰式炸雞飯","Mushroom Bolognese\n番茄蘑菇意麵","Mushroom Carbonara\n白醬蘑菇意麵"]
    
let FoodNames = ["Udon","Rice","Rice","Rice","Noodle","Noodle"]

let FoodTexts = ["香醇濃郁的咖哩，配上滑順Ｑ彈的烏冬，撲鼻而來的濃濃咖哩香，觸發了一口接一口的新滋味！！！","卡滋卡滋的炸雞排，就算是Vegan也能吃到，健康又沒有負擔，快來品嚐看看吧 ！","沒能出國，沒關係！ 來碗韓式炸雞飯吧，一口就抵達了當初在韓國的韓劇浪漫","添上泰式酸甜辣醬，酸酸甜甜，使用獨特醬料醃製的素食炸雞，讓你胃口大開","想要來點濃郁又香甜的番茄醬汁，搭配義式蘑菇獨門工法，太香了！","濃濃的白醬，光澤的麵條完全吸附了醬汁，就像是豆漿與油條般的絕配"]
    
var selectIndex : Int = 0

class ViewController: UIViewController {


    @IBOutlet weak var FoodImageView: UIImageView!
    
    @IBOutlet weak var FoodLabelView: UILabel!
    
    @IBOutlet weak var TextView: UITextView!
    
    @IBOutlet weak var PageView: UIPageControl!
    
    @IBOutlet weak var SegmentedControlView: UISegmentedControl!
    
    @IBOutlet weak var BackgroundView: UIView!
    
    
    @IBOutlet weak var SmokeView: UIImageView!
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        
        //設定圓角、剪裁、初始畫面
                FoodImageView.layer.cornerRadius = 60
                FoodImageView.clipsToBounds = true
                FoodLabelView.text = FoodLables[0]
                TextView.text = FoodTexts[0]
        //設定View圓角、陰影
                BackgroundView.layer.cornerRadius = 30
                BackgroundView.clipsToBounds = true
                BackgroundView.layer.shadowOpacity = 0.8
        
        let snow = CAEmitterCell()
        
        snow.contents = UIImage(named: "snow1")?.cgImage
        
        
        //設定每秒發射幾個雪花，我們指定一秒5個
        snow.birthRate = 5
        
        //雪花維持的秒數，我們讓雪花只停留10秒鐘。
        snow.lifetime = 10
        
        //雪花大小
        snow.scale = 0.2
        
        //雪花大小範圍
        snow.scaleRange = 0.1
        
        //雪花移動的速度。
        snow.velocity = 50
        
        //利用 spin 和 spinRange 設定雪花轉速的範圍為 -0.5(0.5–1) ~ 1.5(0.5+1)，單位為弧度。
        snow.spin = 0.5
        snow.spinRange = 1
        
        //雪花大小改變的速度。小於 0 會愈來愈小，大於 0 會愈來愈大
        snow.scaleSpeed = -0.05
        
        //雪花發射的角度範圍
        snow.emissionRange = CGFloat.pi
        
//當yAcceleration>0時會向下移動，yAcceleration＜0時會向上移動。我們也可以設定xAcceleration，xAcceleration > 0會向右移動，xAcceleration < 0 會向左移動。
        snow.yAcceleration = 30
        
        
        //產生 CAEmitterLayer，將它的 emitterCells 指定為剛剛產生的雪花粒子 snowEmitterCell。
        let snowLayer = CAEmitterLayer()
        snowLayer.emitterCells = [snow]
        
        //因此以下兩行程式將讓雪花從畫面上方的水平線發射
        snowLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: -50)
        snowLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        
        //.line 將讓雪花從水平線發射，路徑的公式如下:
        //Particles are emitted along a line from (emitterPosition.x — emitterSize.width/2, emitterPosition.y, emitterZPosition) to (emitterPosition.x + emitterSize.width/2, emitterPosition.y, emitterZPosition).
        snowLayer.emitterShape = .line
        
        
        //利用 addSublayer 將 snowLayer 的下雪效果加到畫面上。
        view.layer.addSublayer(snowLayer)
        
        playSound(name: "Irasshaimase")
        
        super.viewDidLoad()
    }
    
    //播放各種音效
    func playSound(name:String){
        if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
            self.player = try? AVAudioPlayer(contentsOf: url)
            self.player?.play()
        }
    }
    
    
    
    //定義
    func record() {
        FoodImageView.image = UIImage(named: FoodImages[selectIndex])
        FoodLabelView.text = FoodLables[selectIndex]
        TextView.text = FoodTexts[selectIndex]
        PageView.currentPage = selectIndex
        SegmentedControlView.selectedSegmentIndex = selectIndex
        playSound(name: "next")
    }
//button上一頁  與滑動左邊，使用Any。
    @IBAction func PreviousButton(_ sender: Any) {
        if selectIndex == 0 {
            selectIndex = FoodImages.count-1
        }else{
            selectIndex -= 1
    }
        record()
}
    //button下一頁 與滑動右邊，使用Any。
    @IBAction func NextButton(_ sender: Any) {
        if selectIndex == FoodImages.count-1 {
            selectIndex = 0
        }else{
            selectIndex += 1
        }
        record()
    }
    //頁數圓點
    @IBAction func PageControlButton(_ sender: UIPageControl) {
        selectIndex = sender.currentPage
        if PageView.currentPage == 0 {
            selectIndex = 0
            record()
        }else if PageView.currentPage == 1 {
            selectIndex = 1
            record()
        }else if PageView.currentPage == 2 {
            selectIndex = 2
            record()
        }else if PageView.currentPage == 3 {
            selectIndex = 3
            record()
        }else if PageView.currentPage == 4 {
            selectIndex = 4
            record()
        }else if PageView.currentPage == 5 {
            selectIndex = 5
            record()
        }
    }
    //分頁選項
    @IBAction func SegmentedControlButton(_ sender: UISegmentedControl) {
        selectIndex = sender.selectedSegmentIndex
        if SegmentedControlView.selectedSegmentIndex == 0 {
            selectIndex = 0
            record()
        }else if SegmentedControlView.selectedSegmentIndex == 1 {
            selectIndex = 1
            record()
        }else if SegmentedControlView.selectedSegmentIndex == 2 {
            selectIndex = 2
            record()
        }else if SegmentedControlView.selectedSegmentIndex == 3 {
            selectIndex = 3
            record()
        }else if SegmentedControlView.selectedSegmentIndex == 4 {
            selectIndex = 4
            record()
        }else if SegmentedControlView.selectedSegmentIndex == 5 {
            selectIndex = 5
            record()
        }
    }
}
