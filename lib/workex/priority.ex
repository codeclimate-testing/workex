defmodule Workex.Priority do
  defstruct elements: HashDict.new

  def new, do: %__MODULE__{}

  def empty?(%__MODULE__{elements: elements}), do: (Dict.size(elements) == 0)

  def add(
    %__MODULE__{elements: elements} = priority_rec,
    priority,
    element
  ) when is_number(priority) do
    %__MODULE__{priority_rec |
      elements: Dict.put(elements, priority, [element | (elements[priority] || [])])}
  end

  def to_list(%__MODULE__{elements: elements}) do
    elements
    |> Dict.to_list
    |> Enum.sort(&(&1 > &2))
    |> Stream.map(&(elem(&1, 1)))
    |> Stream.map(&Enum.reverse/1)
    |> Enum.concat
  end
end