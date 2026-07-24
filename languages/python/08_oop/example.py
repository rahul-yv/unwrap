class Animal:
    def __init__(self, name):
        self.name = name

    def speak(self):
        raise NotImplementedError

    def __repr__(self):
        return f"{type(self).__name__}({self.name!r})"


class Dog(Animal):
    def speak(self):
        return f"{self.name} says Woof"


class Cat(Animal):
    def speak(self):
        return f"{self.name} says Meow"


class BuggyKennel:
    tricks = []  # shared across all instances: a common bug

    def add_trick(self, trick):
        self.tricks.append(trick)


class FixedKennel:
    def __init__(self):
        self.tricks = []  # per-instance

    def add_trick(self, trick):
        self.tricks.append(trick)


def demo():
    animals = [Dog("Rex"), Cat("Tom")]
    assert [a.speak() for a in animals] == ["Rex says Woof", "Tom says Meow"]
    assert repr(animals[0]) == "Dog('Rex')"

    buggy_a, buggy_b = BuggyKennel(), BuggyKennel()
    buggy_a.add_trick("sit")
    assert buggy_b.tricks == ["sit"]  # leaked across instances

    fixed_a, fixed_b = FixedKennel(), FixedKennel()
    fixed_a.add_trick("sit")
    assert fixed_b.tricks == []  # independent


if __name__ == "__main__":
    demo()
    print("ok")
