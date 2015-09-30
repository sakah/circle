# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  context '何も入力しなかった場合' do
    subject {User.new}
    it { should_not be_valid }
    it { should have(1).errors_on(:name) }
    it { should have(2).errors_on(:age) }
  end

  context '名前が文字数をオーバーしている場合' do
    subject {User.new(name: 'aaaaaaaaaabbbbbbbbbbc',age: 10)}
    it { should_not be_valid }
    it { should have(1).errors_on(:name) }
    it { should have(0).errors_on(:age) }
  end

  context '年齢が範囲を超えている場合' do
    subject {User.new(name: 'taro',age: 1001)}
    it { should_not be_valid }
    it { should have(0).errors_on(:name) }
    it { should have(1).errors_on(:age) }
  end

  context '正常なデータがセットされた場合' do
    subject {User.new(name: 'taro',age: 20)}
    it { should be_valid }
  end
end
