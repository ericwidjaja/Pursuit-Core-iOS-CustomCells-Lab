import UIKit

class ViewController: UIViewController {
    
    var users = [User]() {
        didSet{
            userTableView.reloadData()
        }
    }
    
    lazy var userTableView: UITableView = {
        let theTableView = UITableView()
        theTableView.dataSource = self
        theTableView.delegate = self
        
        let nib = UINib(nibName: "UserTVCell", bundle: nil)
        theTableView.register(nib, forCellReuseIdentifier: "userTVCell")
        
        //cells - we've created a cell variable that dequeues a cell IB item that we usually see when creating it in storyboard
        
        //    tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "userCell")
        return tableView
    }()
    
    
    
    private func loadUsers() {
        UsersFetchingService.manager.getUsers { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.users = data
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(userTableView)
        loadUsers()
    }
    // Do any additional setup after loading the view.
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: indexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
