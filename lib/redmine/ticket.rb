# encoding: utf-8

module Minedig
  # Redmineのチケットに関する処理をまとめたもの
  class Ticket < Redmine
    attr_reader :ticket

    def initialize(ticket = nilra)
      @ticket = ticket
    end

    # チケットが持っているプロパティの一覧を取得する
    # @return [Array] チケットのプロパティ一覧
    def properties
      ticket.singleton_methods
    end

    def status
      ticket.status["name"]
    end

    def status_id
      ticket.status["id"]
    end

    def project
      ticket.project["name"]
    end

    def project_id
      ticket.project["id"]
    end

    def priority
      ticket.priority["name"]
    end

    def priority_id
      ticket.priority["id"]
    end

    def method_missing( name, *args )
      if ticket.respond_to?(name)
        ticket[name]
      else
        super
      end
    end
  end
end