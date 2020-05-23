defmodule HelloWeb.ErrorViewTest do
  use HelloWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  # If we use only an atom for our module tag, ExUnit assumes that it has a value of trueIf we use only an atom for our module tag, ExUnit assumes that it has a value of true.
  # @moduletag error_view_case: "some_interesting_value"
  @moduletag :error_view_case

  @tag individual_test: "yup"
  test "renders 404.html" do
    assert render_to_string(HelloWeb.ErrorView, "404.html", []) == "Not Found"
  end

  @tag individual_test: "nope"
  test "renders 500.html" do
    assert render_to_string(HelloWeb.ErrorView, "500.html", []) == "Internal Server Error"
  end
end
