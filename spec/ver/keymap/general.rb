require_relative '../../helper'

shared :mode_spec do
  before do
    VER::MajorMode::MODES.clear
    VER::MinorMode::MODES.clear
  end
end

module SpecHandler
  def spec_handler(*args)
    @got = args
  end

  attr_reader :got

  extend self
end

VER.spec do
  describe 'Major mode usage' do
    behaves_like :mode_spec

    it 'creates a major mode on the fly' do
      VER::MajorMode::MODES.key?(:alpha).should.be.false

      VER.major_mode :alpha do
      end

      VER::MajorMode::MODES.key?(:alpha).should.be.true
    end
  end

  describe 'Minor mode usage' do
    behaves_like :mode_spec

    it 'creates a minor mode on the fly' do
      VER::MinorMode::MODES.key?(:alpha).should.be.false

      VER.minor_mode :alpha do
      end

      VER::MinorMode::MODES.key?(:alpha).should.be.true
    end

    it 'can have a handler for missing keys' do
      mode = VER.minor_mode(:alpha){
        handler SpecHandler
        missing :alpha_missing
      }

      got_mode, got_action = mode.resolve(VER::Event['a'])
      got_mode.should == mode
      got_action.invocation.should == :alpha_missing
      got_action.handler.should == SpecHandler
    end

    it 'can nest handlers for missing keys' do
      alpha = VER.minor_mode(:alpha){
        handler SpecHandler
        missing :alpha_missing
      }

      beta = VER.minor_mode(:beta){
        inherits :alpha
        handler SpecHandler
        missing :beta_missing
      }

      got_mode, got_action = alpha.resolve(VER::Event['a'])
      got_mode.should == alpha
      got_action.invocation.should == :alpha_missing
      got_action.handler.should == SpecHandler

      got_mode, got_action = beta.resolve(VER::Event['a'])
      got_mode.should == beta
      got_action.invocation.should == :beta_missing
      got_action.handler.should == SpecHandler
    end
  end
end
