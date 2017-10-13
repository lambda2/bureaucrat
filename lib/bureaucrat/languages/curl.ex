defmodule Bureaucrat.Languages.Curl do
@moduledoc """
This module allow to render curl examples
"""

  def example_request(file, record) do
    host = Application.get_env(:bureaucrat, :host) || ''
    path = case record.query_string do
      "" -> record.request_path
      str -> "#{record.request_path}?#{str}"
    end

    # Request with path and headers
    curl_request = [
      "curl -i -X #{record.method} #{host}#{path}"
    ] ++ curl_headers(record.req_headers)

    file
    |> puts("```shell")
    |> puts(Enum.join(curl_request, " \\\n"))
    #
    # # Request Body if applicable
    # unless record.body_params == %{} do
    #   file
    #   |> puts("-d #{Poison.encode!(record.body_params, pretty: false)}")
    # end

    file
    |> puts("```\n")
  end

  def to_language_tab() do
    "  - shell: cURL"
  end

  @doc """
  Write the list of request/response headers under CURL format
  """
  def curl_headers(headers) do
    Enum.map headers, fn {header, value} ->
      "\t-H \"#{header}:#{value}\""
    end
  end

  # pipeline-able puts
  defp puts(file, string) do
    IO.puts(file, string)
    file
  end

end
