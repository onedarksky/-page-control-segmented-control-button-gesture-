//
//  wheelImageView.swift
//  GameOfTheSpinnerWheel
//
//  Created by 江庸冊 on 2021/11/2.
//

import UIKit

class wheelImageView: UIImageView {
    var currentValue : Double = 0
    func rotateGradually(handler:@escaping(String) -> ()) {
        
        var result = ""
        
        let randomDouble = Double.random(in: 0..<2 * Double.pi) // 產生0~2pi隨機的Double數字,也就是0~360度。
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation") //轉的動畫
        
        CATransaction.begin()
        
        rotateAnimation.fromValue = currentValue
        
        currentValue = currentValue + 100 * Double.pi + randomDouble  //開始到結束之,總共了50圈加上randomDouble度。
        
        let value = currentValue.truncatingRemainder(dividingBy: Double.pi * 2) //取得currentale/Doublepi*2餘數
        
        let degree = value * 180 / Double.pi  //將弧度轉成角度
        
        switch degree {//依照不同角度判斷轉到區塊
            
        //360/14 = 25.7142857  要留空間給透明線的位置，所以必須縮減。
        case 0.5..<25:
            result = "14"
        case 26..<51:
            result = "13"
        case 52..<77:
            result = "12"
        case 78.1428571..<102:
            result = "11"
        case 103..<128:
            result = "10"
        case 129..<154:
            result = "9"
        case 155..<179.22222:
            result = "8"
        case 181..<205:
            result = "7"
        case 206..<231:
            result = "6"
        case 232..<257:
            result = "5"
        case 258..<282:
            result = "4"
        case 283..<308:
            result = "3"
        case 309..<334:
            result = "2"
        case 335..<359.5:
            result = "1"
        default:
            result = "Hit The Line"
        }
        rotateAnimation.toValue = currentValue
        rotateAnimation.isRemovedOnCompletion = false
        //動畫結束後仍保在結束狀態,讓轉盤不會在動畫結束時回到最初狀態。便繼再次轉動。
        rotateAnimation.fillMode = .forwards
        
        rotateAnimation.duration = 4 //動畫持續時間
        
        rotateAnimation.repeatCount = 1 // 重複幾次
        
        CATransaction.setCompletionBlock { //跑完動後要做的事
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){//動畫結束後暫停0.3秒
                handler(result)
            }
        }
        rotateAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 1, 0.9, 0.4, 1.00)
        //用cubic Bezier curve決定動畫速率曲線 //也可以用內建的easeOut
        self.layer.add(rotateAnimation, forKey: nil)
        CATransaction.commit()
    }
}

//原本轉盤的設置位置
//case 0..<25.7142857:     //360/14 = 25.7142857
//result = "14"
//case 25.7142857..<51.4285714:
//result = "13"
//case 51.4285714..<77.1428571:
//result = "12"
//case 77.1428571..<102.857143:
//result = "11"
//case 102.857143..<128.571428:
//result = "10"
//case 128.571428..<154.285714:
//result = "9"
//case 154.285714..<180:
//result = "8"
//case 180..<205.714286:
//result = "7"
//case 205.714286..<231.428571:
//result = "6"
//case 231.428571..<257.142857:
//result = "5"
//case 257.142857..<282.857143:
//result = "4"
//case 282.857143..<308.571428:
//result = "3"
//case 308.571428..<334.285714:
//result = "2"
//case 334.285714..<360:
//result = "1"
//default:
//result = "No idea"
