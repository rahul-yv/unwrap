using System.Diagnostics;

public interface IShape
{
    double Area();
}

public record Rectangle(double Width, double Height) : IShape
{
    public double Area() => Width * Height;
}

public class Program
{
    public static void Main()
    {
        var rect = new Rectangle(3, 4);
        Debug.Assert(rect.Area() == 12);
        Debug.Assert(new Rectangle(3, 4) == new Rectangle(3, 4));
        Debug.Assert(new Rectangle(3, 4) != new Rectangle(4, 3));

        Console.WriteLine("ok");
    }
}
