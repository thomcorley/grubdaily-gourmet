class Hash
  def select_keys(*args)
    select { |k,_| args.include? k }
  end
end
