defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [
    parse_args: 1,
    sort_into_ascending_order: 1,
    convert_to_list_of_maps: 1
  ]

  test "returns :help when -h or --help options are present" do
    assert parse_args(["--help", "anything"]) == :help
  end

  test "returns 3 params if given" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "returns default value if not given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

  test "sorts the data in ascending order of created at" do
    result = sort_into_ascending_order(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: issue["created_at"]
    assert issues == ~w{a b c}
  end

  defp fake_created_at_list(values) do
    data = for value <- values, do: [{"created_at", value}, {"others", "everything"}]
    convert_to_list_of_maps(data)
  end
end
