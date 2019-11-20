import SteamLogin
import TableKit
import Utils

class ProfileViewController: BaseTableViewController<ProfileViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    private enum Mocks {
        
        
        
    }
    
    // MARK: - Views

    

    // MARK: - Properties
    
    lazy var tableDirector = TableDirector(tableView: tableView)

    

    // MARK: - Computed Properties



    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadProfileInfo()
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            section
        ])
    }
    
    // MARK: - Overrides

    

}

// MARK: - Table

private extension ProfileViewController {
    
    // MARK: - Sections
    
    var section: TableSection {
        return TableSection(onlyRows: [
            
        ])
    }
    
    // MARK: - Rows
    
    
    
}

// MARK: - Actions

private extension ProfileViewController {

    

}

// MARK: - Constraints

private extension ProfileViewController {

    

}

// MARK: - Private

private extension ProfileViewController {

    func login() {
        SteamLoginVC.login(from: self) { user, error in
            if let user = user {
                print(user)
            }
        }
    }

}
