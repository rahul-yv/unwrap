use serde::{Deserialize, Serialize};
use std::fmt;
use std::fs;
use std::path::PathBuf;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
struct Task {
    id: u32,
    description: String,
    done: bool,
}

#[derive(Debug)]
struct TaskNotFoundError(u32);

impl fmt::Display for TaskNotFoundError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "no task with id {}", self.0)
    }
}

struct TaskTracker {
    path: PathBuf,
    tasks: Vec<Task>,
    next_id: u32,
}

impl TaskTracker {
    fn new(path: PathBuf) -> Self {
        let tasks: Vec<Task> = fs::read_to_string(&path)
            .ok()
            .and_then(|content| serde_json::from_str(&content).ok())
            .unwrap_or_default();
        let next_id = tasks.iter().map(|t| t.id).max().unwrap_or(0) + 1;
        TaskTracker {
            path,
            tasks,
            next_id,
        }
    }

    fn save(&self) {
        let json = serde_json::to_string(&self.tasks).unwrap();
        fs::write(&self.path, json).unwrap();
    }

    fn add_task(&mut self, description: &str) -> Task {
        let task = Task {
            id: self.next_id,
            description: description.to_string(),
            done: false,
        };
        self.next_id += 1;
        self.tasks.push(task.clone());
        self.save();
        task
    }

    fn list_tasks(&self) -> &[Task] {
        &self.tasks
    }

    fn complete_task(&mut self, id: u32) -> Result<(), TaskNotFoundError> {
        let task = self
            .tasks
            .iter_mut()
            .find(|t| t.id == id)
            .ok_or(TaskNotFoundError(id))?;
        task.done = true;
        self.save();
        Ok(())
    }

    fn remove_task(&mut self, id: u32) -> Result<(), TaskNotFoundError> {
        let index = self
            .tasks
            .iter()
            .position(|t| t.id == id)
            .ok_or(TaskNotFoundError(id))?;
        self.tasks.remove(index);
        self.save();
        Ok(())
    }
}

fn main() {
    let path = std::env::temp_dir().join(format!("unwrap-task-tracker-rs-{}.json", std::process::id()));
    let mut tracker = TaskTracker::new(path.clone());

    let a = tracker.add_task("write lesson");
    assert_eq!(a.id, 1);
    assert_eq!(a.description, "write lesson");
    assert!(!a.done);

    let b = tracker.add_task("review PR");
    assert_eq!(b.id, 2);

    assert_eq!(tracker.list_tasks().len(), 2);

    tracker.complete_task(a.id).unwrap();
    assert!(tracker.list_tasks()[0].done);

    let reloaded = TaskTracker::new(path.clone());
    assert_eq!(reloaded.list_tasks().len(), 2);
    assert!(reloaded.list_tasks()[0].done);

    let mut reloaded = reloaded;
    reloaded.remove_task(b.id).unwrap();
    assert_eq!(reloaded.list_tasks().len(), 1);

    assert!(reloaded.complete_task(999).is_err());

    fs::remove_file(&path).unwrap();

    println!("ok");
}
