#:package Microsoft.Data.Sqlite@10.0.10
#:package SQLitePCLRaw.bundle_e_sqlite3@3.0.4
using Microsoft.Data.Sqlite;
using System.Diagnostics;

using var conn = new SqliteConnection("Data Source=:memory:");
conn.Open();

var create = conn.CreateCommand();
create.CommandText = "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)";
create.ExecuteNonQuery();

var insert = conn.CreateCommand();
insert.CommandText = "INSERT INTO users (name) VALUES ($n)";
insert.Parameters.AddWithValue("$n", "Ada");
insert.ExecuteNonQuery();

var select = conn.CreateCommand();
select.CommandText = "SELECT name FROM users WHERE id = 1";
string name = (string)select.ExecuteScalar()!;
Debug.Assert(name == "Ada");

var missing = conn.CreateCommand();
missing.CommandText = "SELECT name FROM users WHERE id = 999";
object? result = missing.ExecuteScalar();
Debug.Assert(result == null);

Console.WriteLine("ok");
