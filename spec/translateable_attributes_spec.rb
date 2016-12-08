require 'spec_helper'

class Testable
  extend TranslateableAttributes::Methods

  attr_accessor :state

  translate_attributes state: 'states'

  def initialize(state)
    self.state = state
  end
end

I18n.backend.store_translations :en, states: { new: 'Initiated', completed: 'Done', custom: '%{state}' }
I18n.backend.store_translations :lv, states: { new: 'Jauns', completed: 'Pabeigts', custom: '%{state}' }

describe TranslateableAttributes do
  before { I18n.locale = :en }

  context '#translated_attribute' do
    subject { Testable.new('new') }

    it 'should return proper translation when value changes' do
      expect { subject.state = 'completed' }.to change { subject.translated_state }
        .from('Initiated')
        .to('Done')
    end

    it 'should return proper translation when locale changes' do
      expect { I18n.locale = :lv }.to change { subject.translated_state }
        .from('Initiated')
        .to('Jauns')
    end
  end

  context '.translated_attribute' do
    it 'should return proper translation' do
      expect(Testable.translated_state('new')).to eq 'Initiated'
    end

    it 'should handle locale changes' do
      expect { I18n.locale = :lv }.to change { Testable.translated_state 'new' }
        .from('Initiated')
        .to('Jauns')
    end

    it 'should accept additional translation options' do
      expect(Testable.translated_state('custom', state: 'Postponed')).to eq 'Postponed'
    end
  end

  context '.attributes_for_select' do
    it 'should return all possible translations in pairs of [value, translation]' do
      expect(Testable.states_for_select).to eq [['Initiated', :new], ['Done', :completed], ['%{state}', :custom]]
    end

    it 'should handle locale changes' do
      expect { I18n.locale = :lv }.to change { Testable.states_for_select }
        .from([['Initiated', :new], ['Done', :completed], ['%{state}', :custom]])
        .to([['Jauns', :new], ['Pabeigts', :completed], ['%{state}', :custom]])
    end
  end

  context '.possible_attributes' do
    it 'should return all possible values' do
      expect(Testable.possible_states).to eq [:new, :completed, :custom]
    end
  end
end
