
class DefaultTranslationStrategy

  def initialize env, topology
    @env = env
    @topology = topology
  end

  def capistrano_name name
    return name.to_s if @topology[:no_node_suffix]
    "#{name}-#{@env}"
  end

  def hostname name
    return name.to_s if @topology[:no_node_suffix]
    "#{name}-#{@env}"
  end

  def ip_types
    [:admin, :user]
  end

  def ip type, name
    node = @topology[:topology][name]
    return {:ip => node[:ip] || node[:hostname], :hostname => node[:hostname] || node[:ip]} if node[:hostname] || node[:ip]
    raise "No hostname in #{node}"
  end

  def vm_name name
    capistrano_name name
  end

end