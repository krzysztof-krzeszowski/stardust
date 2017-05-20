defmodule AnglePropertyTest do
  use ExUnit.Case
  use ExCheck

  describe "Angle operations checks" do
    property "radians should be different than degrees except 0" do
      for_all number in real() do
        case number do
          0.0 ->
            Stardust.Angle.from_deg(number) == number
          _ ->
            Stardust.Angle.from_deg(number) != number
        end
      end
    end

    property "radians should be equal to argument" do
      for_all number in real() do
        Stardust.Angle.from_rad(number) == number
      end
    end
  end
end
