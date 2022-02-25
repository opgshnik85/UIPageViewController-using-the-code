//
//  MyPageViewController.swift
//  UIPageViewController
//
//  Created by MacBook on 12.02.2022.
//

import UIKit

class MyPageViewController: UIPageViewController {
    
    //MARK: - Variable
    var cars = [CarsHelper]()
    let porsche = UIImage(named: "porsche")
    let lamborghini = UIImage(named: "lamborghini")
    let ferrari = UIImage(named: "ferrari")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Cars"
        
        let firstCar = CarsHelper(name: "Porsche", image: porsche!)
        let secondCar = CarsHelper(name: "Lamborghini", image: lamborghini!)
        let thirdCar = CarsHelper(name: "Ferrari", image: ferrari!)
        
        cars.append(firstCar)
        cars.append(secondCar)
        cars.append(thirdCar)
       
    }
    
    //MARK: - Create VC
   lazy var arrayCarViewController: [CarViewController] = {
        var carVS = [CarViewController]()
        for car in cars {
            carVS.append(CarViewController(carWith: car))
        }
        return carVS
    }()
    
    //MARK: - Init UIPageViewController
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = UIColor.green
        self.dataSource = self
        self.delegate = self
        setViewControllers([arrayCarViewController[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MyPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CarViewController else {return nil}
        if let index = arrayCarViewController.firstIndex(of: viewController) {
                if index > 0 {
            return arrayCarViewController[index - 1]
            }
        }
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CarViewController else {return nil}
        if let index = arrayCarViewController.firstIndex(of: viewController) {
                if index < cars.count - 1 {
            return arrayCarViewController[index + 1 ]
            
            }
        }
        return nil
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cars.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
