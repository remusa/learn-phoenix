defmodule HelloWeb.ErrorView do
  use HelloWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end

  defmodule HelloWeb.SomethingNotFoundError do
    defexception [:message]
  end

  defimpl Plug.Exception, for: HelloWeb.SomethingNotFoundError do
    def status(_exception), do: 404
    def actions(_exception), do: []
  end

  defmodule HelloWeb.SomethingNotFoundError do
    defexception [:message, plug_status: 404]
  end

  defimpl Plug.Exception, for: HelloWeb.SomethingNotFoundError do
    def status(_exception), do: 404
    def actions(_exception), do: [%{
        label: "Run seeds",
        handler: {Code, :eval_file, "priv/repo/seeds.exs"}
      }]
  end
end
