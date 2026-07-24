class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def area(self):
        return self.width * self.height

    def __eq__(self, other):
        if not isinstance(other, Rectangle):
            return NotImplemented
        return (self.width, self.height) == (other.width, other.height)


if __name__ == "__main__":
    assert Rectangle(3, 4).area() == 12
    assert Rectangle(3, 4) == Rectangle(3, 4)
    assert Rectangle(3, 4) != Rectangle(4, 3)
    print("ok")
