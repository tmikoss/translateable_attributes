module TranslateableAttributes
  module Methods
    def translate_attributes(options = {})
      options.each do |attribute, namespace|
        define_method "translated_#{attribute}" do
          value = send(attribute)
          value.present? ? I18n.t("#{namespace}.#{value}", default: value) : value
        end

        define_singleton_method "#{attribute.to_s.pluralize}_for_select" do
          I18n.t(namespace).each_with_object([]) do |(value, translation), collection|
            collection << [translation, value]
          end
        end

        define_singleton_method "translated_#{attribute}" do |value|
          I18n.t([namespace, value].join '.')
        end
      end
    end
  end
end
