#
# 共通で使う関数をまとめている
#
module Redmine

  # HashをOpenStructのオブジェクトへ変換を行う。
  # 引数 :
  # @param data ハッシュデータ
  # @return [OpenStruct] 変換したオブジェクトデータ
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