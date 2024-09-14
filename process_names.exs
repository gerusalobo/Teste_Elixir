defmodule ProcessNames do
  def main do
    IO.puts("Por favor, insira os nomes (uma linha por vez, pressione Enter em uma linha vazia para terminar):")
    input = read_lines([]) |> Enum.reverse() |> Enum.join("\n")

    if input == "" do
      IO.puts("Por favor, insira pelo menos um nome.")
    else
      process_names(input)
    end
  end

  defp read_lines(lines) do
    line = IO.read(:line) |> String.trim()
    if line == "" do
      lines
    else
      read_lines([line | lines])
    end
  end

  defp process_names(input) do
    names = input
            |> String.downcase()
            |> String.split("\n")
            |> Enum.map(&String.trim/1)
            |> Enum.filter(&(&1 != ""))

    result = process_each_name(names, %{})

    IO.puts("Resultado:")
    Enum.each(result, &IO.puts/1)
  end

  defp process_each_name([], _name_count), do: []

  defp process_each_name([name | rest], name_count) do
    count = Map.get(name_count, name, 0) + 1
    name_count = Map.put(name_count, name, count)
    result = ["#{String.capitalize(name)} #{to_roman(count)}"]

    result ++ process_each_name(rest, name_count)
  end

  defp to_roman(num) when is_integer(num) do
    key = ["","C","CC","CCC","CD","D","DC","DCC","DCCC","CM","","X","XX","XXX","XL","L","LX","LXX","LXXX","XC","","I","II","III","IV","V","VI","VII","VIII","IX"]
    thousands = String.duplicate("M", div(num, 1000))
    hundreds = Enum.at(key, div(rem(num, 1000), 100))
    tens = Enum.at(key, div(rem(num, 100), 10) + 10)
    units = Enum.at(key, rem(num, 10) + 20)

    thousands <> hundreds <> tens <> units
  end
end

ProcessNames.main()

