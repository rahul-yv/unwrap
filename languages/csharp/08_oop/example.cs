using System.Diagnostics;

public interface ISpeaker
{
    string Speak();
}

public abstract class Animal(string name) : ISpeaker
{
    public string Name { get; } = name;
    public abstract string Speak();
}

public class Dog(string name) : Animal(name)
{
    public override string Speak() => $"{Name} says Woof";
}

public class Cat(string name) : Animal(name)
{
    public override string Speak() => $"{Name} says Meow";
}

public record Point(int X, int Y);

public class Program
{
    public static void Main()
    {
        var animals = new List<Animal> { new Dog("Rex"), new Cat("Tom") };
        Debug.Assert(animals[0].Speak() == "Rex says Woof");
        Debug.Assert(animals[1].Speak() == "Tom says Meow");

        // polymorphism through the interface
        ISpeaker speaker = new Dog("Fido");
        Debug.Assert(speaker.Speak() == "Fido says Woof");

        // records: value-based equality
        var p1 = new Point(3, 4);
        var p2 = new Point(3, 4);
        Debug.Assert(p1 == p2);
        Debug.Assert(p1.Equals(p2));

        var p3 = p1 with { X = 5 }; // non-destructive copy
        Debug.Assert(p3 == new Point(5, 4));
        Debug.Assert(p1 == new Point(3, 4)); // original unchanged

        Console.WriteLine("ok");
    }
}
