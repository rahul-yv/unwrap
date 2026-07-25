# Task Tracker — Java

See [../README.md](../README.md) for the shared design.

`TaskTracker` wraps a JSON file — hand-rolled serialization/parsing via a fixed-shape regex, since Java has no JSON library in the JDK and this stays a single dependency-free file (matching the launcher pattern `java TaskTracker.java` used elsewhere in this repo). Uses a `record Task` and throws `TaskNotFoundException` for an unknown id.

Run: `java TaskTracker.java`
