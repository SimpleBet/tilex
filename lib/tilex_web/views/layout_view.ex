defmodule TilexWeb.LayoutView do
  use TilexWeb, :view

  @request_tracking Application.get_env(:tilex, :request_tracking)

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def imgur_api_key(conn) do
    current_user(conn) && Application.get_env(:tilex, :imgur_client_id)
  end

  def editor_preference(conn) do
    user = current_user(conn)
    user && user.editor
  end

  def page_title(%{post: post}), do: post.title
  def page_title(%{channel: channel}), do: String.capitalize(channel.name)
  def page_title(%{developer: developer}), do: developer.username
  def page_title(%{page_title: page_title}), do: page_title
  def page_title(_), do: Application.get_env(:tilex, :organization_name)

  def twitter_image_url do
    TilexWeb.Endpoint.static_url() <> "/assets/til_twittercard.png"
  end

  def twitter_title(%Tilex.Post{} = post) do
    Tilex.Post.twitter_title(post)
  end

  def twitter_title(_post) do
    "Today I Learned"
  end

  def twitter_description(%Tilex.Post{} = post) do
    markdown = Tilex.Post.twitter_description(post)

    earmark_options = %Earmark.Options{pure_links: false}

    with {:ok, html, _errors} <- Earmark.as_html(markdown, earmark_options),
         {:ok, fragment} <- Floki.parse_fragment(html) do
      Floki.text(fragment)
    else
      _error ->
        markdown
    end
  end

  def twitter_description(_post) do
    """
    TIL is an open-source project by Simplebet that exists to catalogue the sharing & accumulation of knowledge as it happens day-to-day. Posts have a 200-word limit.
    """
  end

  def request_tracking() do
    @request_tracking
  end
end
