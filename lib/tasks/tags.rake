namespace :tags do
  task export: :environment do
    tags = Tag.find_each.map do |tag|
      { id: tag.id, translations_attributes: tag.translations.as_json(only: %i[language name]) }
    end

    open('tags.json', 'wb+') { |f| f.write tags.to_json }
  end

  task import: :environment do
    Tag.accepts_nested_attributes_for :translations

    open('tags.json', 'r') { |f| Tag.create! JSON.parse f.read }
  end
end
