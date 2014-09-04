#
# 共通で使う関数をまとめている
#

module Redmine
  #
  # Redmine.hash2object
  # 目的 : HashをOpenStructのオブジェクトへ変換を行う。
  # 引数 :
  #  * data - ハッシュデータ
  # 返り値 : 変換したオブジェクトデータ
  #
  def self.hash2object(data)
    result = OpenStruct.new

    data.each do |key, value|
      if value.instance_of?(Hash)
        result[key] = hash2object(value)
      else
        result[key] = value
      end
    end

    result
  end
end