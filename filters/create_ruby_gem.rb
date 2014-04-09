class CreateRubyGem < Scrivener
  attr_accessor :name, :status, :notes

  def validate
    if assert_present(:name)
      assert(Rubygems.exists?(name), [:name, :not_exists])
    end

    assert_member(:status, RubyGem::STATUSES)
  end
end
