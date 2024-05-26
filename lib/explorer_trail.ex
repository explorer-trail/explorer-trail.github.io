defmodule ExplorerTrail do
  use Phoenix.Component
  import Phoenix.HTML

  @output_dir "./output"
  File.mkdir_p!(@output_dir)

  def build() do
    posts = ExplorerTrail.Blog.all_posts()

    render_file("index.html", index(%{posts: posts}))

    for post <- posts do
      dir = Path.dirname(post.path)

      if dir != "." do
        File.mkdir_p!(Path.join([@output_dir, dir]))
      end

      render_file(post.path, post(%{post: post}))
    end

    :ok
  end

  def render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([@output_dir, path])
    File.write!(output, safe)
  end

  def post(assigns) do
    ~H"""
    <.layout>
      <%= raw @post.body %>
    </.layout>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout>
      <h1>Explorer Trail Blog</h1>
      <h2>Posts</h2>
      <ul>
        <li :for={post <- @posts}>
          <a href={post.path}> <%= post.title %></a>
          <div><%= post.date %></div>
          <p><%= post.description %></p>
        </li>
      </ul>
    </.layout>
    """
  end

  def layout(assigns) do
    ~H"""
    <html>
      <head>
        <link rel="stylesheet" href="/assets/app.css" />
        <script type="text/javascript" src="/assets/app.js" />

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lora:ital,wght@0,400..700;1,400..700&display=swap" rel="stylesheet">

      </head>
      <body>
        <%= render_slot(@inner_block) %>
      </body>
    </html>
    """
  end
end
