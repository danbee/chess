defimpl Bamboo.Formatter, for: Chess.Store.User do
  def format_email_address(user, _opts) do
    {user.name, user.email}
  end
end
