package main

import (
	"encoding/json"
	"fmt"
	"os"
)

type Task struct {
	ID          int    `json:"id"`
	Description string `json:"description"`
	Done        bool   `json:"done"`
}

type TaskTracker struct {
	path   string
	tasks  []Task
	nextID int
}

func NewTaskTracker(path string) (*TaskTracker, error) {
	t := &TaskTracker{path: path, nextID: 1}

	data, err := os.ReadFile(path)
	if err == nil {
		if err := json.Unmarshal(data, &t.tasks); err != nil {
			return nil, err
		}
		for _, task := range t.tasks {
			if task.ID >= t.nextID {
				t.nextID = task.ID + 1
			}
		}
	} else if !os.IsNotExist(err) {
		return nil, err
	}

	return t, nil
}

func (t *TaskTracker) save() error {
	data, err := json.Marshal(t.tasks)
	if err != nil {
		return err
	}
	return os.WriteFile(t.path, data, 0644)
}

func (t *TaskTracker) AddTask(description string) (Task, error) {
	task := Task{ID: t.nextID, Description: description, Done: false}
	t.nextID++
	t.tasks = append(t.tasks, task)
	if err := t.save(); err != nil {
		return Task{}, err
	}
	return task, nil
}

func (t *TaskTracker) ListTasks() []Task {
	return t.tasks
}

func (t *TaskTracker) findIndex(id int) (int, error) {
	for i, task := range t.tasks {
		if task.ID == id {
			return i, nil
		}
	}
	return -1, fmt.Errorf("no task with id %d", id)
}

func (t *TaskTracker) CompleteTask(id int) error {
	i, err := t.findIndex(id)
	if err != nil {
		return err
	}
	t.tasks[i].Done = true
	return t.save()
}

func (t *TaskTracker) RemoveTask(id int) error {
	i, err := t.findIndex(id)
	if err != nil {
		return err
	}
	t.tasks = append(t.tasks[:i], t.tasks[i+1:]...)
	return t.save()
}

func main() {
	path := fmt.Sprintf("%s/unwrap-task-tracker-go-%d.json", os.TempDir(), os.Getpid())
	tracker, err := NewTaskTracker(path)
	if err != nil {
		panic(err)
	}

	a, err := tracker.AddTask("write lesson")
	if err != nil || a.ID != 1 || a.Description != "write lesson" || a.Done {
		panic("add a failed")
	}
	b, err := tracker.AddTask("review PR")
	if err != nil || b.ID != 2 {
		panic("add b failed")
	}

	if len(tracker.ListTasks()) != 2 {
		panic("expected 2 tasks")
	}

	if err := tracker.CompleteTask(a.ID); err != nil {
		panic(err)
	}
	if !tracker.ListTasks()[0].Done {
		panic("expected task a done")
	}

	reloaded, err := NewTaskTracker(path)
	if err != nil {
		panic(err)
	}
	if len(reloaded.ListTasks()) != 2 || !reloaded.ListTasks()[0].Done {
		panic("reload failed")
	}

	if err := reloaded.RemoveTask(b.ID); err != nil {
		panic(err)
	}
	if len(reloaded.ListTasks()) != 1 {
		panic("expected 1 task after remove")
	}

	if err := reloaded.CompleteTask(999); err == nil {
		panic("expected error for missing task")
	}

	os.Remove(path)
	fmt.Println("ok")
}
