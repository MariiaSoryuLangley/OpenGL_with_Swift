//
//  ViewController.swift
//  OpenGL_with_Swift2.0
//
//  Created by Mariia on 06.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func GoToSquare(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SquareViewController") as? SquareViewController else {
            return
        }
        present(vc, animated: true)
    }
    
    @IBAction func GoToFox(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FoxViewController") as? FoxViewController else {
            return
        }
        present(vc, animated: true)
    }

    @IBAction func GoToCat(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CatViewController") as? CatViewController else {
            return
        }
        present(vc, animated: true)
    }
    @IBAction func GoToCube(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CubeViewController") as? CubeViewController else {
            return
        }
        present(vc, animated: true)
    }
}

