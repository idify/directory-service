class Subdomain
  def self.matches?(request)
    case request.subdomain
      when 'www', '', nil, 'gentle-forest-8130'
        false
      else
        true
    end
  end
end