defmodule DocTest do
  use ExUnit.Case
  doctest Stardust.Angle, import: true
  doctest Stardust.Observatories, import: true
end
