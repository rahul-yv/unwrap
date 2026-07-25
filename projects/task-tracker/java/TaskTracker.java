import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class TaskNotFoundException extends RuntimeException {
    TaskNotFoundException(int id) {
        super("no task with id " + id);
    }
}

record Task(int id, String description, boolean done) {}

class TaskTracker {
    private static final Pattern TASK_PATTERN = Pattern.compile(
        "\\{\"id\":(\\d+),\"description\":\"([^\"]*)\",\"done\":(true|false)\\}"
    );

    private final Path path;
    private final List<Task> tasks = new ArrayList<>();
    private int nextId = 1;

    TaskTracker(Path path) throws IOException {
        this.path = path;
        if (Files.exists(path)) {
            String content = Files.readString(path, StandardCharsets.UTF_8);
            Matcher m = TASK_PATTERN.matcher(content);
            while (m.find()) {
                int id = Integer.parseInt(m.group(1));
                tasks.add(new Task(id, m.group(2), Boolean.parseBoolean(m.group(3))));
                if (id >= nextId) nextId = id + 1;
            }
        }
    }

    private void save() throws IOException {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < tasks.size(); i++) {
            Task t = tasks.get(i);
            if (i > 0) sb.append(",");
            sb.append("{\"id\":").append(t.id())
              .append(",\"description\":\"").append(t.description())
              .append("\",\"done\":").append(t.done()).append("}");
        }
        sb.append("]");
        Files.writeString(path, sb.toString(), StandardCharsets.UTF_8);
    }

    Task addTask(String description) throws IOException {
        Task task = new Task(nextId++, description, false);
        tasks.add(task);
        save();
        return task;
    }

    List<Task> listTasks() {
        return List.copyOf(tasks);
    }

    private int findIndex(int id) {
        for (int i = 0; i < tasks.size(); i++) {
            if (tasks.get(i).id() == id) return i;
        }
        throw new TaskNotFoundException(id);
    }

    void completeTask(int id) throws IOException {
        int i = findIndex(id);
        tasks.set(i, new Task(tasks.get(i).id(), tasks.get(i).description(), true));
        save();
    }

    void removeTask(int id) throws IOException {
        int i = findIndex(id);
        tasks.remove(i);
        save();
    }

    private static void check(boolean condition, String name) {
        if (!condition) throw new AssertionError(name);
    }

    public static void main(String[] args) throws IOException {
        Path path = Path.of(System.getProperty("java.io.tmpdir"),
            "unwrap-task-tracker-java-" + ProcessHandle.current().pid() + ".json");
        TaskTracker tracker = new TaskTracker(path);

        Task a = tracker.addTask("write lesson");
        check(a.id() == 1 && a.description().equals("write lesson") && !a.done(), "add a");
        Task b = tracker.addTask("review PR");
        check(b.id() == 2, "add b");

        check(tracker.listTasks().size() == 2, "list size 2");

        tracker.completeTask(a.id());
        check(tracker.listTasks().get(0).done(), "a done");

        TaskTracker reloaded = new TaskTracker(path);
        check(reloaded.listTasks().size() == 2, "reloaded size 2");
        check(reloaded.listTasks().get(0).done(), "reloaded a done");

        reloaded.removeTask(b.id());
        check(reloaded.listTasks().size() == 1, "reloaded size 1 after remove");

        boolean threw = false;
        try {
            reloaded.completeTask(999);
        } catch (TaskNotFoundException e) {
            threw = true;
        }
        check(threw, "expected TaskNotFoundException");

        Files.delete(path);
        System.out.println("ok");
    }
}
