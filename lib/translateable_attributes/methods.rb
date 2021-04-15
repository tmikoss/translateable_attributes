module TranslateableAttributes
  module Methods
    # rubocop:disable Metrics/AbcSize
    def translate_attributes(options = {})
      options.each do |attribute, namespace|
        plural_attribute = attribute.to_s.pluralize

        define_method "translated_#{attribute}" do
          value = send(attribute)
          value.present? ? I18n.t("#{namespace}.#{value}", default: value) : value
        end

        define_singleton_method "#{plural_attribute}_for_select" do
          I18n.t(namespace).each_with_object([]) do |(value, translation), collection|
            collection << [translation, value]
          end
        end

        define_singleton_method "translated_#{attribute}" do |value, translation_options = {}|
          I18n.t([namespace, value].join('.'), **translation_options)
        end

        define_singleton_method "possible_#{plural_attribute}" do
          I18n.t(namespace).keys
        end
      end
    end
  end
end
