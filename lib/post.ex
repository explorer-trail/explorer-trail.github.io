defmodule ExplorerTrail.Post do
  @enforce_keys [:id, :author, :title, :body, :description, :tags, :date, :path]
  defstruct [:id, :author, :title, :body, :description, :tags, :date, :path]

  def build(filename, attrs, body) do
    path = Path.rootname(filename)
    [year, month_day_id] = path |> Path.split() |> Enum.take(-2)
    [month, day, id] = String.split(month_day_id, "-", parts: 3)
    date = Date.from_iso8601!("#{year}-#{month}-#{day}")
    path = path <> ".html"
    struct!(__MODULE__, [id: id, date: date, body: body, path: path] ++ Map.to_list(attrs))
  end
end
