defmodule Bureaucrat.Languages.Ruby do
@moduledoc """
This module allow to render curl examples
"""

  def example_request(file, record) do
    host = Application.get_env(:bureaucrat, :host) || ''
    path = case record.query_string do
      "" -> record.request_path
      str -> "#{record.request_path}?#{str}"
    end

    # require 'net/http'
    # require 'json'
    #
    # url = 'https://api.spotify.com/v1/search?type=artist&q=tycho'
    # uri = URI(url)
    # response = Net::HTTP.get(uri)
    # JSON.parse(response)

    file
    |> puts("```ruby")
    |> puts("require 'net/http'")
    |> puts("require 'json'")
    |> puts("url = '#{host}#{path}'")
    |> puts("response = Net::HTTP.#{record.method |> String.downcase}(URI(url))")
    |> puts("JSON.parse(response)")
    |> puts("```\n")
  end

  def to_language_tab() do
    "  - ruby"
  end

  # pipeline-able puts
  defp puts(file, string) do
    IO.puts(file, string)
    file
  end

end
