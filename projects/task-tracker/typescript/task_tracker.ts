import { readFileSync, writeFileSync, existsSync, unlinkSync } from "node:fs";
import assert from "node:assert/strict";
import { tmpdir } from "node:os";
import { join } from "node:path";

interface Task {
  id: number;
  description: string;
  done: boolean;
}

class TaskNotFoundError extends Error {
  constructor(id: number) {
    super(`no task with id ${id}`);
  }
}

class TaskTracker {
  private tasks: Task[] = [];
  private nextId = 1;

  constructor(private path: string) {
    if (existsSync(path)) {
      this.tasks = JSON.parse(readFileSync(path, "utf-8"));
      for (const task of this.tasks) {
        if (task.id >= this.nextId) this.nextId = task.id + 1;
      }
    }
  }

  private save(): void {
    writeFileSync(this.path, JSON.stringify(this.tasks));
  }

  addTask(description: string): Task {
    const task: Task = { id: this.nextId++, description, done: false };
    this.tasks.push(task);
    this.save();
    return task;
  }

  listTasks(): Task[] {
    return [...this.tasks];
  }

  private find(id: number): Task {
    const task = this.tasks.find((t) => t.id === id);
    if (!task) throw new TaskNotFoundError(id);
    return task;
  }

  completeTask(id: number): void {
    this.find(id).done = true;
    this.save();
  }

  removeTask(id: number): void {
    const task = this.find(id);
    this.tasks = this.tasks.filter((t) => t !== task);
    this.save();
  }
}

function main() {
  const path = join(tmpdir(), `unwrap-task-tracker-ts-${process.pid}.json`);
  const tracker = new TaskTracker(path);

  const a = tracker.addTask("write lesson");
  const b = tracker.addTask("review PR");
  assert(a.id === 1 && a.description === "write lesson" && !a.done);
  assert(b.id === 2);

  assert(tracker.listTasks().length === 2);

  tracker.completeTask(a.id);
  assert(tracker.listTasks()[0].done);

  const reloaded = new TaskTracker(path);
  assert(reloaded.listTasks().length === 2);
  assert(reloaded.listTasks()[0].done);

  reloaded.removeTask(b.id);
  assert(reloaded.listTasks().length === 1);

  let threw = false;
  try {
    reloaded.completeTask(999);
  } catch (e) {
    threw = e instanceof TaskNotFoundError;
  }
  if (!threw) throw new Error("expected TaskNotFoundError");

  unlinkSync(path);
  console.log("ok");
}

main();
