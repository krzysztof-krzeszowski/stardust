defmodule Stardust.Angle do
  @moduledoc """
  Functions for angle parsing and calculations.
  """

  @doc """
  Converts degrees to radians.

  ## Examples
      iex> Angle.deg_to_rad(180)
      6.283185307179586
      iex> Angle.deg_to_rad(90.0)
      1.5707963267948966
      iex> Angle.deg_to_rad(35.23)
      0.6148795
  """
  @spec deg_to_rad(integer) :: float
  def deg_to_rad(angle) when is_integer(angle) == true, do: deg_to_rad(angle * 1.0)
  @spec deg_to_rad(float) :: float
  def deg_to_rad(angle), do: angle * :math.pi / 180.0
end
