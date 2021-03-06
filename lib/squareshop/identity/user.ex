defmodule Squareshop.Identity.User do
# adding in needed functions
	use Ecto.Schema
	import Ecto.Changeset
	import Ecto.Association
	require Logger
	schema "users" do
		field :fname, :string
		field :lname, :string
		field :phone, :string
		field :email, :string
		field :password, :string
		has_many :addresses, Squareshop.Identity.Address
		timestamps()
	end
	def changeset(user, attrs, addr) do
		# Logger.debug("user #{inspect(user)}")
		Logger.debug("number 1 ran")
		user
		|> Squareshop.Repo.preload(:addresses)
		|> cast(attrs, [:fname, :lname, :phone, :email, :password])
		|> validate_required([:fname, :lname, :email])
	    |> put_assoc(:addresses, [addr])

	end

	def changeset(user, attrs) do
		user
		|> Squareshop.Repo.preload(:addresses)
		|> cast(attrs, [:fname, :lname, :phone, :email, :password, :id])
		|>cast_assoc(:addresses)
		|> validate_required([:fname, :lname, :email])
	end

end
