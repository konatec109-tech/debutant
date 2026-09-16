defmodule Kpay.Wallet.Operation.OnboardClient do
  use Ash.Resource.Change

  @impl true
  def change(changeset, _opts, _context) do
    Ash.Changeset.before_action(changeset, fn changeset ->
      tenant_id = Ash.Changeset.get_argument(changeset, :bank_tenant_id)
      name = Ash.Changeset.get_argument(changeset, :name)
      phone = Ash.Changeset.get_argument(changeset, :phone)
      changeset |> Ash.Changeset.force_change_attribute(:bank_tenant_id, tenant_id)





    end)
  end

  defp changeset(changeset) do
    Ash.Changeset.after_action(changeset, fn _changeset, wallet ->
      changeset =
        Kpay.Wallet.Account
        |> Ash.Changeset.for_create(:create,
        [name: name, phone: phone, wallet_id: wallet.id])
     end)
  end

  defp creating(changeset) do
    
  end
end
