defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1 ]

  test "returns :help when -h or --help options are present" do
    assert parse_args(["--help", "anything"]) == :help
  end

  test "returns 3 params if given" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "returns default value if not given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end
end
