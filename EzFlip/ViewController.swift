//
//  ViewController.swift
//  EzFlip
//
//  Created by Tu on 3/27/17.
//
//

import UIKit

class ViewController: UIViewController {
    var tag = 100
    var temp = 100
    var rect = UIView()
    var isFlip = false
    var isFlipped = false
    var arr = [UIView]()
    var TimerFlipForward = Timer()
    var TimerFlipBackward = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 1, animations: {
            self.draw()
        }, completion: nil)
    }
    
    func draw(){
        let cellWidth = self.view.bounds.width/4
        for col in 0..<4{
            for row in 0..<4{
                self.rect = UIView(frame: CGRect(x: 20, y: 20, width: cellWidth - 20 , height: cellWidth - 20 ))
                self.rect.backgroundColor = UIColor.gray
                self.rect.tag = tag
                tag += 1
                self.rect.center = CGPoint(x: cellWidth*CGFloat(row) + 55 , y: cellWidth*CGFloat(col) + 100)
                arr.append(rect)
                view.addSubview(rect)
            }
        }
        
    }
    
//    func flip(){
//        
//        if self.isFlip == false {
//            for rect in view.subviews{
//                for col in 0..<4{
//                    for row in 0..<4{
//                        if rect.tag == self.tag+col*10+row{
//                            print(rect.tag)
//                            delay(Double(col) * 1.5 + Double(row) * 0.5, closure: {
//                                
//                                UIView.transition(with: rect, duration: 0.5, options: .transitionFlipFromRight, animations: {
//                                    rect.backgroundColor = UIColor.black
//                                    
//                                }, completion: nil)
//                            })
//                        }
//                    }
//                }
//                
//            }
//            isFlip = true
//        }
//        else {
//            for rect in view.subviews{
//                for col in 0..<3{
//                    for row in 0..<3{
//                        if rect.tag == self.tag+col*10+row{
//                            print(self.isFlip)
//                            delay(Double(col) * 1.5 + Double(row) * 0.5, closure: {
//                                UIView.transition(with: rect, duration: 0.5, options: .transitionFlipFromRight, animations: {
//                                    rect.backgroundColor = UIColor.gray
//                                }, completion: nil)
//                            })
//                        }
//                    }
//                }
//            }
//            isFlip = false
//        }
//    }
    
    func flipForward(){
        for index in stride(from: 0, to: arr.capacity, by: 1) {
            rect = arr[index]
            print(rect)
            if rect.tag == temp {
                //print(rect.tag)
                UIView.transition(with: rect, duration: 0.5, options: .transitionFlipFromRight, animations: {
                    self.rect.backgroundColor = UIColor.black
                }, completion: nil)
            }
            else if temp == 115  {
                TimerFlipForward.invalidate()
                TimerFlipBackward = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.flipBackward), userInfo: nil, repeats: true);
            }
        }
        temp += 1
    }
    
    
    func delay(_ delay:Double, closure:@escaping ()->()){
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    func flipBackward(){
        for index in stride(from: arr.capacity-1, to: 0, by: -1) {
            rect = arr[index]
            print(rect)
            if rect.tag == temp {
                UIView.transition(with: rect, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                    self.rect.backgroundColor = UIColor.gray
                }, completion: nil)
            }
            else if temp == 100 {
                TimerFlipBackward.invalidate()
                TimerFlipForward = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.flipForward), userInfo: nil, repeats: true);
            }
        }
        temp -= 1
    }
    
    @IBAction func act_Flip(_ sender: Any) {
        TimerFlipForward = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.flipForward), userInfo: nil, repeats: true);
    }
    
}

