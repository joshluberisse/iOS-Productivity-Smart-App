
import SwiftUI
import UIKit


class TaskCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GoalCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProductivityApp: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of tasks in the tasks array
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)

        // Configure the cell with the task at the given index
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task

        return cell
    }
    
    // MARK: - Properties
    struct TimeBlock {
        var startTime: Date
        var endTime: Date
    }

    // task management properties
    var tasks: [String] = []
    var taskDueDates: [Date] = []

    // time management properties
    var timeBlocks: [TimeBlock] = []

    // progress tracking properties
    var completedTasks: [String] = []
    
    // The app's window
    var window: UIWindow?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // set up task management UI elements
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.register(GoalCell.self, forCellReuseIdentifier: "GoalCell")
        view.addSubview(tableView)

        // Add a button to create a new task or goal
        let addButton = UIButton(type: .system)
        addButton.setTitle("Add Task or Goal", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)

        // Use Auto Layout constraints to position and size the table view and add button
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false

        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: margins.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor),

            addButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            addButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    // MARK: - Actions

    @objc func addButtonTapped() {
        // show a form to create a new task or goal
        print("Add button tapped")
    }

    // MARK: - Task Management

    func addTask(task: String, dueDate: Date) {
        tasks.append(task)
        taskDueDates.append(dueDate)
    }

    func editTask(at index: Int, newTask: String, newDueDate: Date)
 {
        tasks[index] = newTask
        taskDueDates[index] = newDueDate
    }

    func deleteTask(at index: Int) {
        tasks.remove(at: index)
     taskDueDates.remove(at: index)
}

// MARK: - Time Management

func addTimeBlock(startTime: Date, endTime: Date) {
    let timeBlock = TimeBlock(startTime: startTime, endTime: endTime)
    timeBlocks.append(timeBlock)
}

func editTimeBlock(at index: Int, newStartTime: Date, newEndTime: Date) {
    var timeBlock = timeBlocks[index]
    timeBlock.startTime = newStartTime
    timeBlock.endTime = newEndTime
}
}
// MARK: - Main Function


class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    var window: UIWindow?

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Create an instance of the ProductivityApp class
        let app = ProductivityApp()

        // Set up the app's window and make it visible
        app.window = UIWindow(frame: UIScreen.main.bounds)
        app.window?.makeKeyAndVisible()

        // Set the root view controller of the app's window
        app.window?.rootViewController = app

        return true
    }
}
