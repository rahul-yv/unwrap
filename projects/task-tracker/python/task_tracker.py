import json
import os
from dataclasses import dataclass, asdict


@dataclass
class Task:
    id: int
    description: str
    done: bool


class TaskNotFoundError(Exception):
    pass


class TaskTracker:
    def __init__(self, path: str):
        self.path = path
        self.tasks: list[Task] = []
        self._next_id = 1
        if os.path.exists(path):
            with open(path) as f:
                raw = json.load(f)
            self.tasks = [Task(**item) for item in raw]
            if self.tasks:
                self._next_id = max(t.id for t in self.tasks) + 1

    def _save(self):
        with open(self.path, "w") as f:
            json.dump([asdict(t) for t in self.tasks], f)

    def add_task(self, description: str) -> Task:
        task = Task(id=self._next_id, description=description, done=False)
        self._next_id += 1
        self.tasks.append(task)
        self._save()
        return task

    def list_tasks(self) -> list[Task]:
        return list(self.tasks)

    def _find(self, task_id: int) -> Task:
        for t in self.tasks:
            if t.id == task_id:
                return t
        raise TaskNotFoundError(f"no task with id {task_id}")

    def complete_task(self, task_id: int) -> None:
        self._find(task_id).done = True
        self._save()

    def remove_task(self, task_id: int) -> None:
        task = self._find(task_id)
        self.tasks.remove(task)
        self._save()


def main():
    import tempfile

    path = os.path.join(tempfile.gettempdir(), f"unwrap-task-tracker-{os.getpid()}.json")
    tracker = TaskTracker(path)

    a = tracker.add_task("write lesson")
    b = tracker.add_task("review PR")
    assert a.id == 1 and a.description == "write lesson" and not a.done
    assert b.id == 2

    assert len(tracker.list_tasks()) == 2

    tracker.complete_task(a.id)
    assert tracker.list_tasks()[0].done

    reloaded = TaskTracker(path)
    assert len(reloaded.list_tasks()) == 2
    assert reloaded.list_tasks()[0].done

    reloaded.remove_task(b.id)
    assert len(reloaded.list_tasks()) == 1

    threw = False
    try:
        reloaded.complete_task(999)
    except TaskNotFoundError:
        threw = True
    assert threw

    os.remove(path)
    print("ok")


if __name__ == "__main__":
    main()
