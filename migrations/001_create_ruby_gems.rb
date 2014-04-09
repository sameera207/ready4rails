Sequel.migration do
  change do
    create_table(:ruby_gems) do
      primary_key(:id)

      String(:name, size: nil, null: false)
      String(:status, size: nil, null: false)
      String(:notes, text: true)
      DateTime(:created_at)
      DateTime(:updated_at)

      index(:name, unique: true)
      index(:status)
    end
  end
end
