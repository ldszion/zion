# Funcoes auxiliares para a Conta (account)
module AccountHelper
  # Retorna ou a url do avatar da conta ou a url padrao
  def account_thumbnail(account)
    return 'avatar.jpg' if account.nil?
    account.avatar.image.url(:thumb)
  end
end
