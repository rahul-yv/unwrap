#:package Microsoft.Data.Sqlite@10.0.10
#:package SQLitePCLRaw.bundle_e_sqlite3@3.0.4
using Microsoft.Data.Sqlite;
using System.Diagnostics;

string? GetUserName(SqliteConnection conn, long id)
{
	var select = conn.CreateCommand();
	select.CommandText = "SELECT name FROM users WHERE id = $id";
	select.Parameters.AddWithValue("$id", id);
	return (string?)select.ExecuteScalar();
}

using var conn = new SqliteConnection("Data Source=:memory:");
conn.Open();

var create = conn.CreateCommand();
create.CommandText = "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)";
create.ExecuteNonQuery();

var insert = conn.CreateCommand();
insert.CommandText = "INSERT INTO users (name) VALUES ($n)";
insert.Parameters.AddWithValue("$n", "Ada");
insert.ExecuteNonQuery();

Debug.Assert(GetUserName(conn, 1) == "Ada");
Debug.Assert(GetUserName(conn, 999) == null);

Console.WriteLine("ok");
