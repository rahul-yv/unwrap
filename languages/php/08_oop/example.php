<?php

interface Greetable
{
    public function greet(): string;
}

class Person implements Greetable
{
    public function __construct(
        private readonly string $name
    ) {}

    public function greet(): string
    {
        return "Hello, {$this->name}!";
    }
}

enum Status: string
{
    case Active = "active";
    case Inactive = "inactive";
}

trait Loggable
{
    public function log(string $message): string
    {
        return "[" . static::class . "] $message";
    }
}

class Service
{
    use Loggable;
}

$ada = new Person("Ada");
assert($ada->greet() === "Hello, Ada!");

assert(Status::Active->value === "active");
assert(Status::from("inactive") === Status::Inactive);

$service = new Service();
assert($service->log("started") === "[Service] started");

echo "ok\n";
