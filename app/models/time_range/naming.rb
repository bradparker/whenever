module TimeRange::Naming
  def name
    self.class.name.downcase.to_sym
  end
end
