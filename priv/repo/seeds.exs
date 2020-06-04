# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tilex.Repo.insert!(%Tilex.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Tilex.{Channel, Developer, Post, Repo}

Repo.delete_all(Post)
Repo.delete_all(Channel)
Repo.delete_all(Developer)

phoenix_channel = Repo.insert!(%Channel{name: "phoenix", twitter_hashtag: "phoenix"})
elixir_channel = Repo.insert!(%Channel{name: "elixir", twitter_hashtag: "myelixirstatus"})
erlang_channel = Repo.insert!(%Channel{name: "erlang", twitter_hashtag: "erlang"})
python_channel = Repo.insert!(%Channel{name: "python", twitter_hashtag: "python"})
devops_channel = Repo.insert!(%Channel{name: "devops", twitter_hashtag: "devops"})
postgresql_channel = Repo.insert!(%Channel{name: "postgresql", twitter_hashtag: "postgresql"})
cli_channel = Repo.insert!(%Channel{name: "command-line", twitter_hashtag: "cli"})
