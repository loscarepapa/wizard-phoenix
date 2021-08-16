defmodule GenioTest.Quote.Vehicle do 
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :make, :string
    field :year_model, :string
    field :version, :string
    field :serie_number, :string
    field :motor, :string
  end

  @cast_params ~w(make year_model version serie_number motor)a

  def changeset(vehicle, attr \\ %{}) do
    vehicle
    |> cast(attr, @cast_params)
    |> validate_required([:make, :year_model, :version])
  end
end
