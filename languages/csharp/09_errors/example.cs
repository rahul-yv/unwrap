using System.Diagnostics;

public class InsufficientFundsException : Exception
{
    public decimal Balance { get; }
    public decimal Amount { get; }
    public InsufficientFundsException(decimal balance, decimal amount)
        : base("insufficient funds")
    {
        Balance = balance;
        Amount = amount;
    }
}

public class Program
{
    static double Divide(double a, double b)
    {
        if (b == 0)
        {
            throw new DivideByZeroException();
        }
        return a / b;
    }

    public static void Main()
    {
        Debug.Assert(Divide(10, 2) == 5);

        bool caught = false;
        bool finallyRan = false;
        try
        {
            Divide(10, 0);
        }
        catch (DivideByZeroException)
        {
            caught = true;
        }
        finally
        {
            finallyRan = true;
        }
        Debug.Assert(caught && finallyRan);

        // custom exception carrying data
        bool caughtCustom = false;
        try
        {
            throw new InsufficientFundsException(10m, 50m);
        }
        catch (InsufficientFundsException e)
        {
            caughtCustom = true;
            Debug.Assert(e.Balance == 10m && e.Amount == 50m);
            Debug.Assert(e.Message == "insufficient funds");
        }
        Debug.Assert(caughtCustom);

        // exception filter (when)
        bool filtered = false;
        try
        {
            throw new InvalidOperationException("retryable");
        }
        catch (InvalidOperationException e) when (e.Message == "retryable")
        {
            filtered = true;
        }
        Debug.Assert(filtered);

        Console.WriteLine("ok");
    }
}
