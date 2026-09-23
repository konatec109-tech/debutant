defmodule Kpay.Wallets.Operations.OnboardClient do
  use Ash.Resource.Change

  @impl true
  def change(changeset, _opts, _context) do
    Ash.Changeset.before_action(changeset, fn changeset ->
      tenant_id = Ash.Changeset.get_argument(changeset, :bank_tenant_id)
      name = Ash.Changeset.get_argument(changeset, :name)
      phone = Ash.Changeset.get_argument(changeset, :phone)
      changeset =
        changeset
        |> Ash.Changeset.manage_relationship(:bank_tenant, tenant_id, type: :append_and_remove)
      changeset(changeset, name, phone)
    end)
  end

  defp changeset(changeset, name, phone) do
    Ash.Changeset.after_action(changeset, fn _changeset, wallet ->
      changeset =
        Kpay.Wallets.Account
        |> Ash.Changeset.for_create(:create,
        [name: name, phone: phone, wallet_id: wallet.id])

      case Ash.create(changeset) do
        {:ok, _account} ->
          {:ok, wallet}

        {:error, account_error} ->
          normalize_error(account_error)

        reason ->
          normalize_error(reason)
      end
    end)
  end

  defp normalize_error(reason) when is_atom(reason), do: {:error, reason}
  defp normalize_error(reason) do
      IO.inspect(reason, label: "PROCESS FAILED")
      {:error, :account_creation_failed}
  end

end
