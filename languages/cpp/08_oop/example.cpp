#include <cassert>
#include <iostream>
#include <memory>
#include <string>
#include <utility>
#include <vector>

class Animal {
public:
    explicit Animal(std::string name) : name_(std::move(name)) {}
    virtual ~Animal() = default;
    virtual std::string speak() const = 0;

protected:
    std::string name_;
};

class Dog : public Animal {
public:
    explicit Dog(std::string name) : Animal(std::move(name)) {}
    std::string speak() const override {
        return name_ + " says Woof";
    }
};

class Cat : public Animal {
public:
    explicit Cat(std::string name) : Animal(std::move(name)) {}
    std::string speak() const override {
        return name_ + " says Meow";
    }
};

int main() {
    std::unique_ptr<Animal> pet = std::make_unique<Dog>("Rex");
    assert(pet->speak() == "Rex says Woof");

    // polymorphism: a vector of base pointers, each dispatching to its concrete type
    std::vector<std::unique_ptr<Animal>> animals;
    animals.push_back(std::make_unique<Dog>("Rex"));
    animals.push_back(std::make_unique<Cat>("Tom"));

    assert(animals[0]->speak() == "Rex says Woof");
    assert(animals[1]->speak() == "Tom says Meow");

    std::cout << "ok\n";
    return 0;
}
