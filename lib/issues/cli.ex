defmodule Issues.CLI do
  @moduledoc """
  Handles the command line parsing and dispatch to various functions that end
  up generating the table of last n issues in a GitHub project
  """

  @default_count 4

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  argv can be -h or --help, which returns :help.
  Otherwise it is a github user name, project name, and (optional)
  the number of entries to format.
  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ], aliases: [ h: :help ])
    case parse do
      { [ help: true ], _, _ } -> :help
      { _, [ user, project, count ], _ } -> { user, project, String.to_integer(count) }
      { _, [ user, project ], _ } -> { user, project, @default_count }
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count}  ]
    """
    System.halt(0)
  end

  def process({ user, project, _count }) do
    Issue.GithubIssues.fetch(user, project)
  end
end
