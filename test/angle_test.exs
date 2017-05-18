defmodule AnglePropertyTest do
  use ExUnit.Case
  use ExCheck

  describe "Angle operations checks" do
    property "radians should be different than degrees except 0" do
      for_all number in real() do
        case number do
          0.0 ->
            (Stardust.Angle.new(number) |> Map.get(:angle)) == number
          _ ->
            (Stardust.Angle.new(number) |> Map.get(:angle)) != number
        end
      end
    end
  end
end
